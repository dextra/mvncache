dic_proxy = YAML.load_file("#{RAILS_ROOT}/config/mvncache-config.yml")[RAILS_ENV]

PROXY_HOST = dic_proxy['proxy_host']
PROXY_PORT = dic_proxy['proxy_port']
 CACHE_DIR = dic_proxy['cache_dir']
PROXY_USER = dic_proxy['proxy_user']
PROXY_PASS = dic_proxy['proxy_pass']