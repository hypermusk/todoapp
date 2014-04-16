package hypermusk.todoapi;



import android.util.Log;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonParseException;

import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.lang.reflect.Type;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.zip.GZIPInputStream;

public class Todoapi {
	public static Todoapi _instance;
	public static String dateformat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ";
	public static String dateformat2 = "yyyy-MM-dd'T'HH:mm:ssZZZZ";
	private static SimpleDateFormat _formatter = new SimpleDateFormat(dateformat);
	private static SimpleDateFormat _formatter2 = new SimpleDateFormat(dateformat2);

	public static Todoapi get() {
		if (_instance == null) {
			_instance = new Todoapi();
		}
		return _instance;
	}

	private class DateDeserializer implements JsonDeserializer<Date> {
		public Date deserialize(JsonElement json, Type typeOfT, JsonDeserializationContext context)
				throws JsonParseException {
			String dateString = json.getAsJsonPrimitive().getAsString();

			int len = dateString.length();
			// get rid of ":" in the last timezone 08:00 of 2013-07-16T14:26:41.499+08:00
			if (dateString.charAt(len-3) == ':' && dateString.charAt(len-6) == '+') {
				dateString = dateString.substring(0, len-3) + dateString.substring(len-2, len);
			} else if (dateString.charAt(len-1) == 'Z') {
				dateString = dateString.substring(0, len-1) + "+0000";
			}

			Date r = null;
			try {
				r = _formatter.parse(dateString);
			} catch (ParseException e) {
				try {
					r = _formatter2.parse(dateString);
				} catch (ParseException n) {
					Log.d("Exception", "Can't parse time " + n.getMessage());
				}
      }

			return r;
		}
	}

	public Gson _gson;

	public Gson gson() {
		 if (_gson == null) {
			 GsonBuilder b = new GsonBuilder();
			 b.setDateFormat(dateformat);
			 b.setPrettyPrinting();
			 b.registerTypeAdapter(Date.class, new DateDeserializer());
			 _gson = b.create();
		 }
		return _gson;
	}

	public static class RequestResult {
		private Reader reader;
		private RemoteError err;

		public Reader getReader() {
			return reader;
		}

		public void setReader(Reader reader) {
			this.reader = reader;
		}

		public RemoteError getErr() {
			return err;
		}

		public void setErr(RemoteError err) {
			this.err = err;
		}
	}

	public static RequestResult request(String url, String body, InputStream stream) {
		RequestResult r = new RequestResult();
		try {
			URL u = new URL(url);

			HttpURLConnection conn = (HttpURLConnection)u.openConnection();

			conn.setRequestMethod("POST");
			if (stream == null) {
				conn.setRequestProperty("Content-Type", "application/json;charset=utf-8");
			} else {
				conn.setRequestProperty("Content-Type", "application/octet-stream");
				conn.setRequestProperty("X-HyperMuskStreamParams", Base64.encodeToString(body.getBytes(), Base64.NO_WRAP));
			}
			conn.setRequestProperty("Accept-Encoding", "gzip, deflate");

			conn.setDoInput(true);
			conn.setDoOutput(true);

			DataOutputStream wr = new DataOutputStream(conn.getOutputStream ());

			if (stream == null) {
				wr.write(body.getBytes());
			} else {
				byte[] buffer = new byte[4096];
				int n;
				while ((n = stream.read(buffer)) > 0) {
					wr.write(buffer, 0, n);
				}
				stream.close();
			}
			wr.flush();
			wr.close();

			InputStream is = conn.getInputStream();
			if (conn.getContentEncoding().equals("gzip")) {
				is = new GZIPInputStream(is);
			}
			r.setReader(new InputStreamReader(is));

		} catch (IOException e) {
			RemoteError err = new RemoteError();
			err.setMessage(e.getMessage());
			err.setCode("-1");
			Map reason = new HashMap();
			reason.put("OriginalException", e);
			err.setReason(reason);
			r.setErr(err);
		}

		return r;
	}

	private String baseURL;

	public String getBaseURL() {
		return baseURL;
	}

	public void setBaseURL(String baseURL) {
		this.baseURL = baseURL;
	}

	private boolean verbose;

	public boolean isVerbose() {
		return verbose;
	}

	public void setVerbose(boolean verbose) {
		this.verbose = verbose;
	}

}

