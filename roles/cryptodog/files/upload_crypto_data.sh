gsutil -m cp -z csv -a public-read -n /mnt/crypto-data/*.csv gs://crypto-storage-bucket
find /mnt/crypto-data -maxdepth 1 -type f -mmin -10 -printf "gs://crypto-storage-bucket/%f\n" | gsutil -m rm -I
