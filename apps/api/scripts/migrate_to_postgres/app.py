import uuid
from budimongo import BudiMongo
from budipostgres import BudiPostgres

budi_mongo = BudiMongo()
budi_postgres = BudiPostgres()

# get all old toilets from mongodb
old_toilets = budi_mongo.get_old_toilets()

# extract data to different tables
new_toilets = []
temp_user_ids = []
users = []
votes = []
notes = []
budipest_default_id = str(uuid.uuid4())

for ot in old_toilets:
    # create new toilet uuid
    toilet_id = str(uuid.uuid4())

    # extract toilet-only data
    new_toilets.append({
        'id': toilet_id,
        'open_hours': '{' + ','.join([str(oh) for oh in ot['openHours']]) + '}',
        'user_id': ot['userId'] if ot['userId'] != 'BUDIPEST-DEFAULT' else budipest_default_id,
        'name': ot['name'],
        'created_at': ot['addDate'],
        'category': ot['category'].lower(),
        'wheelchair_accessible': ot['tags']['WHEELCHAIR_ACCESSIBLE'],
        'baby_room': ot['tags']['BABY_ROOM'],
        'entry_method': ot['entryMethod'].lower(),
        'code': ot['code'],
        'latitude': ot['location']['latitude'],
        'longitude': ot['location']['longitude'],
        'price_huf': ot.get('price', {}).get('HUF', None),
        'price_eur': ot.get('price', {}).get('EUR', None)
    })
    temp_user_ids.append(ot['userId'])

    # extract votes
    for v in ot['votes']:
        votes.append({
            'toilet_id': toilet_id,
            'user_id': v['userId'],
            'value': 'like' if v['value'] == 1 else 'dislike',
        })
        temp_user_ids.append(v['userId'])

    # extract notes
    for n in ot['notes']:
        notes.append({
            'toilet_id': toilet_id,
            'user_id': n['userId'],
            'note': n['text'],
            'created_at': n['addDate']
        })
        temp_user_ids.append(n['userId'])

# generate users
for user_id in temp_user_ids:
    if user_id not in [u['username'] for u in users]:
        users.append({
            'id': user_id if user_id != 'BUDIPEST-DEFAULT' else budipest_default_id,
            'username': user_id,
            'role': 'guest'
        })

# insert users first
for user in users:
    budi_postgres.insert(user, 'users')
budi_postgres.save()

# insert toilets
for toilet in new_toilets:
    budi_postgres.insert(toilet, 'toilets')
budi_postgres.save()

# insert votes and notes
for vote in votes:
    budi_postgres.insert(vote, 'votes')
for note in notes:
    budi_postgres.insert(note, 'notes')
budi_postgres.save()

budi_postgres.close()
