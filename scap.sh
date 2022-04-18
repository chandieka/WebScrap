destination="A-wonderful-new-world";
link="https://manhwa365.com/webtoon/a-wonderful-new-world-english/chapter-";
pattern="https://img.manhwa365.com/site-1/a-wonderful-new-world-english-.*(jpg|jpeg|png)"
start=51;
end=130;

if [[ -d "$destination" ]]; then
    # rm -r $destination;
    # mkdir $destination;
    echo "using an existing dir";
else
    mkdir $destination;
fi

function scrap() {
while [[ $start -le end ]]; do
    # wait for N amount time so that it doenst get recognized as botting
    sleep 0.6;

    # create new dir for a chapter
    mkdir "./${destination}/chapter-${start}"

    # fetch the html file
    echo "[$start] fetching html file";
    wget -q -O "./${destination}/chapter-${start}/temp.html" "${link}${start}/";
    # process the html file to get the images URL and output it to a file
    echo "[$start] applying search pattern";
    grep -Eo $pattern ./${destination}/chapter-${start}/temp.html > "./${destination}/chapter-${start}/links.txt";
    rm "./${destination}/chapter-${start}/temp.html"

    # mass download the images using the url list from the previous file 
    echo "[$start] downloading images";
    cat "./${destination}/chapter-${start}/links.txt" | while read file; do
        sleep 0.5
        wget -q -P "./${destination}/chapter-${start}/" ${file} &
    done 
    # wget -q -P "./${destination}/chapter-${start}/" -i "./${destination}/chapter-${start}/links.txt";
    rm "./${destination}/chapter-${start}/links.txt";
    echo "[$start] Finish downloading";
    start=$((start + 1));
    # repeat
done
}

scrap;