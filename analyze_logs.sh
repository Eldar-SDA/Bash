# Заголовок отчета
echo "Отчет о логе веб-сервера" > report.txt

echo "========================" >> report.txt


# Общее количество запросов
total=$(awk '{ count++ } END { print count }' access.log)
echo -e "Общее количество запросов:" $total >> report.txt

#Количество уникальных IP-адресов.
unique=$(awk '{ seen[$1]++ } END { print length(seen) }' access.log)
echo -e "Количество уникальных IP-адресов:" $unique >> report.txt

#Количество запросов по методам (GET, POST и т.д.).
echo -e "\n\nКоличество запросов по методам:" >> report.txt
awk '{method = $6; gsub(/"/, "", method); if (method != "") methods[method]++} END {for (method in methods) print method, methods[method]}' access.log >> report.txt

#Самый популярный URL
popular=$(awk '{urls[$7]++} END {max=0; for (url in urls) {if (urls[url] > max) {max = urls[url]; popular = url}} print popular}' access.log)
echo -e "\nСамый популярный URL:" $popular >> report.txt 

echo -e "\nОтчет сохранен в файл report.txt"
