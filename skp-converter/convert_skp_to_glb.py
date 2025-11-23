#!/usr/bin/env python3
"""
SKP to GLB converter using assimp and Blender
Usage: python3 convert_skp_to_glb.py input.skp output.glb
"""

import sys
import os
import subprocess
import tempfile

def convert_with_assimp(input_file, output_file):
    """
    Convert SKP to GLB using assimp command-line tool
    """
    print(f"Converting {input_file} to {output_file} using assimp...")

    # Check if input file exists
    if not os.path.exists(input_file):
        print(f"Error: Input file not found: {input_file}")
        return False

    try:
        # Use assimp to convert SKP to GLB
        # assimp export <input> <output> -f <format>
        result = subprocess.run(
            [
                "assimp", "export",
                input_file,
                output_file,
                "-f", "glb2"
            ],
            capture_output=True,
            text=True,
            timeout=120
        )

        print(f"Assimp stdout: {result.stdout}")
        print(f"Assimp stderr: {result.stderr}")
        print(f"Assimp returncode: {result.returncode}")

        if result.returncode == 0 and os.path.exists(output_file):
            print(f"✅ Conversion successful: {output_file}")
            return True
        else:
            print(f"❌ Assimp conversion failed")
            return False

    except subprocess.TimeoutExpired:
        print("❌ Assimp conversion timeout")
        return False
    except Exception as e:
        print(f"❌ Assimp error: {str(e)}")
        return False

def convert_with_blender_obj_intermediate(input_file, output_file):
    """
    Convert SKP to GLB using intermediate OBJ format via Blender
    SKP -> (assimp) -> OBJ -> (blender) -> GLB
    """
    print(f"Converting {input_file} to {output_file} using assimp+Blender (via OBJ)...")

    # Create temporary OBJ file
    with tempfile.NamedTemporaryFile(suffix='.obj', delete=False) as tmp_obj:
        obj_path = tmp_obj.name

    try:
        # Step 1: Convert SKP to OBJ using assimp
        print("Step 1: Converting SKP to OBJ...")
        result = subprocess.run(
            ["assimp", "export", input_file, obj_path, "-f", "obj"],
            capture_output=True,
            text=True,
            timeout=120
        )

        if result.returncode != 0 or not os.path.exists(obj_path):
            print(f"❌ SKP to OBJ failed: {result.stderr}")
            return False

        print(f"✅ OBJ created: {obj_path}")

        # Step 2: Convert OBJ to GLB using Blender
        print("Step 2: Converting OBJ to GLB...")
        blender_script = f"""
import bpy
import sys

# Clear scene
bpy.ops.wm.read_homefile(use_empty=True)

# Import OBJ
bpy.ops.wm.obj_import(filepath="{obj_path}")

# Export as GLB
bpy.ops.export_scene.gltf(
    filepath="{output_file}",
    export_format='GLB',
    export_texcoords=True,
    export_normals=True,
    export_materials='EXPORT',
    export_colors=True,
    export_cameras=False,
    export_lights=False,
)

print("✅ GLB export successful")
"""

        with tempfile.NamedTemporaryFile(mode='w', suffix='.py', delete=False) as tmp_script:
            tmp_script.write(blender_script)
            script_path = tmp_script.name

        try:
            result = subprocess.run(
                ["blender", "-b", "--python", script_path],
                capture_output=True,
                text=True,
                timeout=120
            )

            print(f"Blender stdout: {result.stdout}")
            print(f"Blender stderr: {result.stderr}")

            if os.path.exists(output_file):
                print(f"✅ Conversion successful: {output_file}")
                return True
            else:
                print(f"❌ GLB file not created")
                return False

        finally:
            if os.path.exists(script_path):
                os.unlink(script_path)

    finally:
        if os.path.exists(obj_path):
            os.unlink(obj_path)

def main():
    if len(sys.argv) < 3:
        print("Error: Need input and output file paths")
        print("Usage: python3 convert_skp_to_glb.py input.skp output.glb")
        sys.exit(1)

    input_file = sys.argv[1]
    output_file = sys.argv[2]

    print(f"Converting {input_file} to {output_file}")

    # Check if input file exists
    if not os.path.exists(input_file):
        print(f"Error: Input file not found: {input_file}")
        sys.exit(1)

    # Try direct assimp conversion first
    if convert_with_assimp(input_file, output_file):
        sys.exit(0)

    # If assimp fails, try intermediate OBJ method
    print("\n⚠️ Direct conversion failed, trying intermediate OBJ method...")
    if convert_with_blender_obj_intermediate(input_file, output_file):
        sys.exit(0)

    # Both methods failed
    print("\n❌ All conversion methods failed")
    sys.exit(1)

if __name__ == "__main__":
    main()
