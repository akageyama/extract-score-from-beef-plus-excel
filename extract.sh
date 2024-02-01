#!/bin/sh
#
#
# 2024.02.01

# BEEF+では、ある授業科目の全小テスト結果をまとめてダウンロード
# することができない。小テストを実施した回数だけ手で「答案ダウンロード」
# ボタンをクリックするする必要がある。そうしてダウンロードされた
# ファイルは「問題」と「解答」という名前の2枚のシートから構成
# されるエクセルファイルである。
#
# このシェルスクリプトからPythonスクリプトを呼び出している。それは、
# 各エクセルファイルの「解答」シートから学籍番号と氏名、そして小テスト
# 点数（一番右のカラム）を抽出するPythonスクリプトである。
#
# このPythonスクリプトは小テストを受験する学生の人数が必ずしも毎回同じ
# でなくてもよいようにしている。逆に言えば総得点を集計するときに単純に
# 全データを同じ行で足し算してはいけない。
#
# 使い方は以下の通り：
# 
# 1. 「小テスト素点」ディレクトリに全小テストのエクセルファイルを入れる
# 2. このシェルスクリプトを実行する

for excel_file_name in 小テスト素点/*.xlsx
do
  filename_without_extension=`basename $excel_file_name .xlsx`
  fileid=`basename $filename_without_extension | rev | cut -d_ -f1 | rev`
  echo === fileid=$fileid
  ./extract_student_id_and_score_from_xlsx.py $excel_file_name > 小テスト素点から点数抽出/$fileid.csv
done
