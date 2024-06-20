: 'curl -X GET \
     -H "Content-type: application/json" \
     -H "Accept: application/json" \
     -d '{"routine_id": "c2e8dbbf-72c8-4464-bf7e-5259d2efc77e", "user_id": "a8ce98b8-c0a9-4b5a-a605-377e159c320a"}' \
     "http://localhost:4000/routine/home" 
'

: 'curl -X GET \
     -H "Content-type: application/json" \
     -H "Accept: application/json" \
     -d '{"routine_id": "c2e8dbbf-72c8-4464-bf7e-5259d2efc77e", "day_id": "4052d78b-d34f-499c-8311-feb1b0e0a416"}' \
     "http://localhost:4000/routine/day_details" 
'

: 'curl -X GET \
     -H "Content-type: application/json" \
     -H "Accept: application/json" \
     -d '{"user_id": "a8ce98b8-c0a9-4b5a-a605-377e159c320a"}' \
     "http://localhost:4000/home/details/"
'

: 'curl -X POST \
     -H "Content-type: application/json" \
     -H "Accept: application/json" \
     -d '{
         "name": "Dumbell Lunges",
         "description": "Step forward with dumbells",
         "muscle_groups": ["78d6b0b9-5247-4006-b6d1-7faf6475bbea", "d0fdc293-75fe-4894-8f32-ab1906e9e89c"]
         }' \
     "http://localhost:4000/exercise/create/"
'

: 'curl -X POST \
     -H "Content-type: application/json" \
     -H "Accept: application/json" \
     -d '{
         "id": "2e21269f-3656-40f1-bb65-2a0f8102182c",
         "name": "Dumbell Super Lunges",
         "description": "Step forward then backward with dumbells",
         "muscle_groups": []
         }' \
     "http://localhost:4000/exercise/edit/"
'

: 'curl -X POST \
     -H "Content-type: application/json" \
     -H "Accept: application/json" \
     -d '{
         "name": "Routine #2 Leg Destroyer",
         "creator_user_id": "a8ce98b8-c0a9-4b5a-a605-377e159c320a"
         }' \
     "http://localhost:4000/routine/create"
'

curl -X POST \
     -H "Content-type: application/json" \
     -H "Accept: application/json" \
     -d '{
         "id": "7793faa0-9dd8-4b16-bdcb-fe7bfe681d64",
         "name": "Routine #2 Super Leg Destroyer"
         }' \
     "http://localhost:4000/routine/edit"



