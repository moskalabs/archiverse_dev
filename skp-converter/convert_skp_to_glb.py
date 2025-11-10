#!/usr/bin/env blender --python
"""
Blender Python script to convert SKP to GLB
Usage: blender -b --python convert_skp_to_glb.py -- input.skp output.glb
"""

import bpy
import sys
import os

def main():
    # Get command line arguments after "--"
    argv = sys.argv
    if "--" not in argv:
        print("Error: No arguments provided")
        sys.exit(1)

    argv = argv[argv.index("--") + 1:]

    if len(argv) < 2:
        print("Error: Need input and output file paths")
        print("Usage: blender -b --python convert_skp_to_glb.py -- input.skp output.glb")
        sys.exit(1)

    input_file = argv[0]
    output_file = argv[1]

    print(f"Converting {input_file} to {output_file}")

    # Check if input file exists
    if not os.path.exists(input_file):
        print(f"Error: Input file not found: {input_file}")
        sys.exit(1)

    # Clear default scene
    bpy.ops.wm.read_homefile(use_empty=True)

    try:
        # Import SKP file using SketchUp Importer addon
        # Addon required: https://github.com/RedHaloStudio/Sketchup_Importer
        if input_file.endswith('.skp'):
            print("Importing SKP file using SketchUp Importer addon...")

            # Debug: List all enabled addons
            print(f"DEBUG: Enabled addons: {list(bpy.context.preferences.addons.keys())}")

            # Debug: List addon paths
            addon_paths = bpy.utils.script_paths()
            print(f"DEBUG: Script paths: {addon_paths}")

            # Try to enable addon if not already enabled
            if 'sketchup_importer' not in bpy.context.preferences.addons:
                print("Addon not enabled, attempting to enable it...")
                try:
                    bpy.ops.preferences.addon_enable(module='sketchup_importer')
                    print("Successfully enabled sketchup_importer addon")
                except Exception as e:
                    print(f"Failed to enable addon: {e}")
                    print("Error: SketchUp Importer addon not found!")
                    sys.exit(1)

            # Import SKP file
            bpy.ops.import_scene.skp(filepath=input_file)
            print(f"Import successful")
        else:
            print(f"Error: Expected .skp file, got {input_file}")
            sys.exit(1)

    except Exception as e:
        print(f"Error importing file: {str(e)}")
        sys.exit(1)

    try:
        # Export as GLB
        bpy.ops.export_scene.gltf(
            filepath=output_file,
            export_format='GLB',
            export_texcoords=True,
            export_normals=True,
            export_materials='EXPORT',
            export_colors=True,
            export_cameras=False,
            export_lights=False,
        )
        print(f"Export successful: {output_file}")

    except Exception as e:
        print(f"Error exporting file: {str(e)}")
        sys.exit(1)

if __name__ == "__main__":
    main()
