printf "" > pages.h

ls -la *.html > pages

while IFS= read -r line; do
    name=$(printf '%s' "$line" | grep -Eo "\w+\.html$" | awk -F. '{print $1}')

    echo "Building $name"
    
    printf 'R"kotw(\n' > "$name.h"
    cat "$name.html" >> "$name.h"
    printf '\n)kotw";' >> "$name.h"

    printf "const char* page_$name =\n#include \"$name.h\"\n" >> pages.h
done < pages

rm pages