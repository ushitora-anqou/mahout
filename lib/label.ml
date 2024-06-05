let prefix = "mahout.anqou.net/"
let mastodon_key = prefix ^ "mastodon"
let deploy_image_key = prefix ^ "deploy-image"
let nginx_conf_cm_hash_key = prefix ^ "nginx-conf-hash"
let web_restart_time_key = prefix ^ "webRestartTime"
let sidekiq_restart_time_key = prefix ^ "sidekiqRestartTime"

let encode_deploy_image image =
  Base64.encode_string ~alphabet:Base64.uri_safe_alphabet ~pad:false image

let deploy_pod_labels ~name ~image =
  `Assoc
    [
      (mastodon_key, `String name);
      (deploy_image_key, `String (encode_deploy_image image));
    ]
