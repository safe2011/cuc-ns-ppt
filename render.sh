#!/usr/bin/env bash
# ref: https://github.com/jgm/pandoc/wiki/Using-pandoc-to-produce-reveal.js-slides

output_dir=(
"."
"server"
"client"
)

secret=(
"''"  
"'${PRETOKEN}'"
"null"
)

for input in ./*.md;do
    if [[ "$input" == "./README.md" ]];then
      continue
    fi
    if [[ "$input" == "./index.md" ]];then
      # 生成默认首页
      pandoc index.md -s -o index.html
      continue
    fi
    i=0
    for dir in "${output_dir[@]}";do
      output_ppt="${dir}/${input}.html"
      pandoc -t revealjs --template=lib/revealjs.template.html -s "${input}" -V theme=white -V transition=fade -V incremental=true -V slideNumber=true -o "${output_ppt}" -V revealjs-url="lib/reveal.js" -V history=true --no-highlight -V hlss=zenburn -V mathjax=true -V multiplex=true -V multiplex-secret="${secret[$i]}" -V multiplex-id="${PREID}" -V multiplex-server="${PRESERVER}"
      i=$((i+1))
    done
done
