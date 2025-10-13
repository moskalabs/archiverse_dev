#!/usr/bin/env python3
"""
ResponsiveLayoutWrapper 제거 스크립트
"""

import os
import re

target_pages = [
    'lib/pages/dahsboard_general/dahsboard_general_widget.dart',
    'lib/pages/dahsboard/dahsboard_widget.dart', 
    'lib/pages/dahsboard_vice/dahsboard_vice_widget.dart',
    'lib/pages/dahsboard_master/dahsboard_master_widget.dart',
    'lib/pages/professor/dashboard/prof_dashboard/prof_dashboard_widget.dart',
    'lib/pages/student/dashboard/student_dashboard/student_dashboard_widget.dart',
    'lib/pages/admin/dashboard/admin_dash/admin_dash_widget.dart',
    'lib/pages/professor/home/home_widget.dart',
    'lib/pages/student/student_home/student_home_widget.dart',
    'lib/pages/admin/account_management/admin_account_manage/admin_account_manage_widget.dart',
]

def remove_responsive_wrapper(file_path):
    """ResponsiveLayoutWrapper 제거"""
    try:
        if not os.path.exists(file_path):
            return False
            
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        original_content = content
        
        # 1. import 제거
        content = re.sub(
            r"import '/components/layout/responsive_layout_wrapper/responsive_layout_wrapper_widget\.dart';\n",
            "",
            content
        )
        
        # 2. ResponsiveLayoutWrapper( 제거하고 내용만 남기기
        content = re.sub(
            r'(\s+)ResponsiveLayoutWrapperWidget\(\s*child:\s*',
            r'\1',
            content
        )
        
        # 3. 대응하는 닫는 괄호 제거 (간단한 방법)
        lines = content.split('\n')
        for i in range(len(lines)-1, -1, -1):
            if '),\n        ),' in '\n'.join(lines[max(0,i-1):i+2]):
                lines[i] = lines[i].replace('),', ')')
                break
        content = '\n'.join(lines)
        
        if content != original_content:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(content)
            print(f"✅ {file_path}")
            return True
        else:
            print(f"⏭️  변경사항 없음: {file_path}")
            return False
            
    except Exception as e:
        print(f"❌ 오류: {file_path} - {e}")
        return False

def main():
    print("🗑️  ResponsiveLayoutWrapper 제거 중...\n")
    
    updated_count = 0
    for file_path in target_pages:
        if remove_responsive_wrapper(file_path):
            updated_count += 1
    
    print(f"\n📊 작업 완료: {updated_count}/{len(target_pages)} 파일에서 제거됨")

if __name__ == "__main__":
    main()