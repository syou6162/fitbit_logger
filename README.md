# Usage

```bash
curl -XDELETE http://localhost:9200/fitbit
curl -XPUT localhost:9200/fitbit
curl -XPUT localhost:9200/fitbit/log/_mapping -d @log_mapping.json

seq 0 6 |
  parallel -k "date -j -v-{}d +'%Y-%m-%d'" |
  parallel -k -j 1 "sleep 30; ruby fitbit_logger.rb {}" |
  jq -c '.' |
  while read line
  do
    id=$(echo $line | jq -c '.date' | tr -d "\n")
    echo "{ \"index\" : { \"_index\" : \"fitbit\", \"_type\" : \"log\", \"_id\" : ${id}} }\n$line" | curl -XPOST localhost:9200/_bulk --data-binary @-
  done
```
