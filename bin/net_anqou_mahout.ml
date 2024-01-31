open K

module V1alpha1 = struct
  module Mastodon = struct
    module Web = struct
      type t = { replicas : int [@yojson.key "replicas"] }
      [@@deriving yojson, show, make] [@@yojson.allow_extra_fields]
    end

    module Sidekiq = struct
      type t = { replicas : int [@yojson.key "replicas"] }
      [@@deriving yojson, show, make] [@@yojson.allow_extra_fields]
    end

    module Streaming = struct
      type t = { replicas : int [@yojson.key "replicas"] }
      [@@deriving yojson, show, make] [@@yojson.allow_extra_fields]
    end

    module Spec = struct
      type t = {
        image : string; [@yojson.key "image"]
        env_from : Io_k8s_api_core_v1_env_from_source.t list;
            [@yojson.default []] [@yojson.key "envFrom"]
        web : Web.t option; [@yojson.default None] [@yojson.key "web"]
        sidekiq : Sidekiq.t option;
            [@yojson.default None] [@yojson.key "sidekiq"]
        streaming : Streaming.t option;
            [@yojson.default None] [@yojson.key "streaming"]
      }
      [@@deriving yojson, show, make] [@@yojson.allow_extra_fields]
    end

    module Status = struct
      type t = {
        message : string option; [@yojson.default None] [@yojson.key "message"]
        server_name : string option;
            [@yojson.default None] [@yojson.key "serverName"]
      }
      [@@deriving yojson, show, make] [@@yojson.allow_extra_fields]
    end

    type t = {
      api_version : string option;
          [@yojson.default None] [@yojson.key "apiVersion"]
      kind : string option; [@yojson.default None] [@yojson.key "kind"]
      metadata : Io_k8s_apimachinery_pkg_apis_meta_v1_object_meta.t option;
          [@yojson.default None] [@yojson.key "metadata"]
      spec : Spec.t option; [@yojson.default None] [@yojson.key "spec"]
      status : Status.t option; [@yojson.default None] [@yojson.key "status"]
    }
    [@@deriving yojson, show, make] [@@yojson.allow_extra_fields]
  end
  [@@warning "-32"]
end