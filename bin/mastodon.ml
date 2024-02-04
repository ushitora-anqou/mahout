exception Not_implemented

module Bare = struct
  type t = Net_anqou_mahout.V1alpha1.Mastodon.t
  type t_list = |

  let metadata (m : t) = m.metadata
  let to_list _ = raise Not_implemented

  let watch_namespaced ~sw client ?headers:_ ~namespace ?allow_watch_bookmarks:_
      ?continue:_ ?field_selector:_ ?label_selector:_ ?limit:_ ?pretty:_
      ?resource_version:_ ?resource_version_match:_ ?send_initial_events:_
      ?timeout_seconds:_ ?watch () =
    Mahout_v1alpha1_api.watch_mahout_v1alpha1_namespaced_mastodon ~sw client
      ?watch () ~namespace

  let patch_status ~sw client ?headers:_ ~name ~namespace ~body ?pretty:_
      ?dry_run:_ ?field_manager:_ ?field_validation:_ ?force:_ () =
    Mahout_v1alpha1_api.patch_mahout_v1alpha1_namespaced_mastodon_status ~sw
      client ~name ~namespace ~body ()

  let of_yojson = Net_anqou_mahout.V1alpha1.Mastodon.of_yojson
  let to_yojson = Net_anqou_mahout.V1alpha1.Mastodon.to_yojson

  let read_namespaced =
    Mahout_v1alpha1_api.read_mahout_v1alpha1_namespaced_mastodon

  let create_namespaced ~sw:_ _client ?headers:_ ~namespace:_ ~body:_ ?pretty:_
      ?dry_run:_ ?field_manager:_ ?field_validation:_ () =
    raise Not_implemented

  let delete_namespaced ~sw:_ _client ?headers:_ ~name:_ ~namespace:_ ?pretty:_
      ?dry_run:_ ?grace_period_seconds:_ ?orphan_dependents:_
      ?propagation_policy:_ ~body:_ () =
    raise Not_implemented

  let patch_namespaced ~sw:_ _client ?headers:_ ~name:_ ~namespace:_ ~body:_
      ?pretty:_ ?dry_run:_ ?field_manager:_ ?field_validation:_ ?force:_ () =
    raise Not_implemented

  let watch_for_all_namespaces ~sw:_ _client ?headers:_ ?allow_watch_bookmarks:_
      ?continue:_ ?field_selector:_ ?label_selector:_ ?limit:_ ?pretty:_
      ?resource_version:_ ?resource_version_match:_ ?send_initial_events:_
      ?timeout_seconds:_ ?watch:_ () =
    raise Not_implemented

  let list_namespaced ~sw:_ _client ?headers:_ ~namespace:_ ?pretty:_
      ?allow_watch_bookmarks:_ ?continue:_ ?field_selector:_ ?label_selector:_
      ?limit:_ ?resource_version:_ ?resource_version_match:_
      ?send_initial_events:_ ?timeout_seconds:_ ?watch:_ () =
    raise Not_implemented

  let list_for_all_namespaces ~sw:_ _client ?headers:_ ?allow_watch_bookmarks:_
      ?continue:_ ?field_selector:_ ?label_selector:_ ?limit:_ ?pretty:_
      ?resource_version:_ ?resource_version_match:_ ?send_initial_events:_
      ?timeout_seconds:_ ?watch:_ () =
    raise Not_implemented

  let replace_namespaced ~sw:_ _client ?headers:_ ~name:_ ~namespace:_ ~body:_
      ?pretty:_ ?dry_run:_ ?field_manager:_ ?field_validation:_ () =
    raise Not_implemented

  let read_status =
    Mahout_v1alpha1_api.read_mahout_v1alpha1_namespaced_mastodon_status

  let replace_status =
    Mahout_v1alpha1_api.replace_mahout_v1alpha1_namespaced_mastodon_status
end

include K.Make (Bare)

let make = Net_anqou_mahout.V1alpha1.Mastodon.make
