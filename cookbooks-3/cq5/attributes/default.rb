# default Cq5 installation attributes
default["cq5"]["port"] = 4502
default["cq5"]["installation_dir"] = "/data/cq5"
default["cq5"]["installation_type"] = "author"
default["cq5"]["sling_run_modes"] = default["cq5"]["installation_type"]
default["cq5"]["min_heap"] = 256
default["cq5"]["max_heap"] = 1024
default["cq5"]["perm_gen"] = 300
default["cq5"]["is_reinstall"] = false
default["cq5"]["version"] = "5_4"
default["cq5"]["5_4"]["jar_url"] = "http://static.content.akqa.net/static/content/cq5/5.4/cq-author-4502.jar"
default["cq5"]["5_4"]["script_path"] = "/crx-quickstart/server"
default["cq5"]["5_4"]["pid_file_path"] = "/crx-quickstart/logs"

default["cq5"]["5_5"]["jar_url"] = "http://static.content.akqa.net/static/content/cq5/5.5/cq-quickstart-5.5.0-20120220.jar"
default["cq5"]["5_5"]["script_path"] = "/crx-quickstart/bin"
default["cq5"]["5_5"]["pid_file_path"] = "/crx-quickstart/conf"


