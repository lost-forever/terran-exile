feast_archon:
    type: data
    exp$archon: true
    name: <green>Archon of the Feast
    podium:
    - composter
    - hay_block
    - oak_slab
    offering: vanilla_tagged:villager_plantable_seeds
    altar_sounds:
    - block_grass_step
    - block_gravel_step
    - item_crop_plant
    rewards:
        items:
        - cooked_chicken
        - cooked_cod
        - cooked_mutton
        - cooked_porkchop
        - cooked_rabbit
        - cooked_salmon
        - cooked_beef

metallurgy_archon:
    type: data
    exp$archon: true
    name: <red>Archon of Metallurgy
    podium:
    - raw_iron_block
    - tuff
    - stone_slab
    offering: vanilla_tagged:trim_materials
    altar_sounds:
    - block_gilded_blackstone_step
    - block_gilded_blackstone_hit
    - block_deepslate_step
    - block_deepslate_hit
    rewards:
        items:
        - iron_ingot
        - copper_ingot
        - gold_ingot

gemstones_archon:
    type: data
    exp$archon: true
    name: <aqua>Archon of Gemstones
    podium:
    - emerald_block
    - diamond_block
    - quartz_slab|smooth_quartz_slab
    offering: netherite_scrap
    altar_sounds:
    - block_amethyst_block_step
    - block_amethyst_block_hit
    - block_metal_step
    - block_metal_hit
    rewards:
        items:
        - emerald
        - lapis_lazuli
        - diamond

magic_archon:
    type: data
    exp$archon: true
    name: <light_purple>Archon of Magic
    podium:
    - warped_stem
    - nether_wart_block
    - nether_brick_slab
    offering: blaze_powder|nether_wart|sugar|redstone
    rewards:
        effects:
        - speed
        - fast_digging
        - increase_damage
        - regeneration
        - damage_resistance
