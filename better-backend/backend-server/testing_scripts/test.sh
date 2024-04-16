: 'curl -X GET \
     -H "Content-type: application/json" \
     -H "Accept: application/json" \
     -d '{"routine_id": "c2e8dbbf-72c8-4464-bf7e-5259d2efc77e", "user_id": "a8ce98b8-c0a9-4b5a-a605-377e159c320a"}' \
     "http://localhost:4000/routine/home" 
'

curl -X GET \
     -H "Content-type: application/json" \
     -H "Accept: application/json" \
     -d '{"routine_id": "c2e8dbbf-72c8-4464-bf7e-5259d2efc77e", "day_id": "4052d78b-d34f-499c-8311-feb1b0e0a416"}' \
     "http://localhost:4000/routine/day_details" 


