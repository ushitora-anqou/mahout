open K

module V1alpha1 = struct
  module Mastodon = struct
    module Periodic_restart = struct
      type t = {
        schedule : string option; [@yojson.default None] [@yojson.key "schedule"]
      }
      [@@deriving yojson, show, make] [@@yojson.allow_extra_fields]
    end

    module Web = struct
      type t = {
        replicas : int32 option; [@yojson.default None] [@yojson.key "replicas"]
        annotations : Yojson.Safe.t option; [@yojson.default None]
        periodic_restart : Periodic_restart.t option;
            [@yojson.default None] [@yojson.key "periodicRestart"]
      }
      [@@deriving yojson, show, make] [@@yojson.allow_extra_fields]
    end

    module Sidekiq = struct
      type t = {
        replicas : int32 option; [@yojson.default None] [@yojson.key "replicas"]
        annotations : Yojson.Safe.t option; [@yojson.default None]
      }
      [@@deriving yojson, show, make] [@@yojson.allow_extra_fields]
    end

    module Streaming = struct
      type t = {
        replicas : int32 option; [@yojson.default None] [@yojson.key "replicas"]
        annotations : Yojson.Safe.t option; [@yojson.default None]
      }
      [@@deriving yojson, show, make] [@@yojson.allow_extra_fields]
    end

    module Gateway = struct
      type t = {
        replicas : int32 option; [@yojson.default None] [@yojson.key "replicas"]
        image : string; [@yojson.default ""] [@yojson.key "image"]
        annotations : Yojson.Safe.t option; [@yojson.default None]
      }
      [@@deriving yojson, show, make] [@@yojson.allow_extra_fields]
    end

    module Spec = struct
      type t = {
        server_name : string; [@yojson.key "serverName"]
        image : string; [@yojson.key "image"]
        env_from : Io_k8s_api_core_v1_env_from_source.t list;
            [@yojson.default []] [@yojson.key "envFrom"]
        web : Web.t option; [@yojson.default None] [@yojson.key "web"]
        sidekiq : Sidekiq.t option;
            [@yojson.default None] [@yojson.key "sidekiq"]
        streaming : Streaming.t option;
            [@yojson.default None] [@yojson.key "streaming"]
        gateway : Gateway.t option;
            [@yojson.default None] [@yojson.key "gateway"]
      }
      [@@deriving yojson, show, make] [@@yojson.allow_extra_fields]
    end

    module Status = struct
      type t = {
        migrating_image : string option;
            [@yojson.default None] [@yojson.key "migratingImage"]
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

    type t_list = {
      api_version : string option;
          [@yojson.default None] [@yojson.key "apiVersion"]
      items : t list; [@default []] [@yojson.key "items"]
      kind : string option; [@yojson.default None] [@yojson.key "kind"]
      metadata : Io_k8s_apimachinery_pkg_apis_meta_v1_list_meta.t option;
          [@yojson.default None] [@yojson.key "metadata"]
    }
    [@@deriving yojson, show, make] [@@yojson.allow_extra_fields]
  end
  [@@warning "-32"]
end
