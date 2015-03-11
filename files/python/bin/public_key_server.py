import BaseHTTPServer

PORT_NUMBER = 16000 # Maybe set this to 9000.

public_key_file_data = ""

with open('/var/lib/jenkins/.ssh/id_rsa.pub','r') as public_key_file:
    public_key_file_data = public_key_file.read()
public_key_file.closed


class SingleFileHandler(BaseHTTPServer.BaseHTTPRequestHandler):
    def do_HEAD(s):
        s.send_response(200)
        s.send_header("Content-type", "text/plain")
        s.end_headers()
    def do_GET(s):
        """Respond to a GET request."""
        s.send_response(200)
        s.send_header("Content-type", "text/plain")
        s.end_headers()
        s.wfile.write(public_key_file_data)

if __name__ == '__main__':
    server_class = BaseHTTPServer.HTTPServer
    httpd = server_class(("", PORT_NUMBER), SingleFileHandler)
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        pass
    httpd.server_close()