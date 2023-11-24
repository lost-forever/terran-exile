_exp_flag_archon_materials:
    type: task
    debug: false
    definitions: type|matcher|archon
    script:
    - define matched <server.material_types.find_all_matches[<[matcher]>]>
    - if <[matched].is_empty>:
        - stop
    - define matched <server.material_types.get[<[matched]>]>
    - flag server exp.mats.<[type]>:<server.flag[exp.mats.<[type]>].include[<[matched]>]>
    - flag <[matched]> exp.podium_<[type]>:<[archon]>
    altar:
    - run _exp_flag_archon_materials def:altar|<[archon].parsed_key[podium].last>|<[archon]>
    offering:
    - run _exp_flag_archon_materials def:offering|<[archon].parsed_key[offering]>|<[archon]>

exp_load_archons:
    type: world
    debug: false
    events:
        after scripts loaded:
        # Reset archon material flags
        - if <server.has_flag[exp.mats]>:
            - flag <server.flag[exp.mats.altar]> exp.podium_altar:!
            - flag <server.flag[exp.mats.offering]> exp.podium_offering:!
        # Reset archon material cache
        - flag server exp.mats:<map[altar=<list>;offering=<list>]>
        # Find archon scripts
        - define scripts <util.scripts.filter_tag[<[filter_value].data_key[exp$archon].exists>]>
        - define map <[scripts].parse[name].map_with[<[scripts]>]>
        # Flag podium and offering materials
        - foreach <[scripts]> key:name as:archon:
            - inject _exp_flag_archon_materials.altar
            - inject _exp_flag_archon_materials.offering
        # Flag archon scripts and log info
        - flag server exp.archons:<[map]>
        - debug log "Archon scripts loaded (<[map].size>): <[map].keys.parse_tag[<aqua><[parse_value]>].separated_by[<reset>, ]>"
