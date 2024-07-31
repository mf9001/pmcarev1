import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from firebase_admin import firestore
from google.cloud.firestore_v1.base_query import FieldFilter

def db_init():
    cred = credentials.Certificate("pmcaredb-firebase-adminsdk-1e4nr-fcdb5f0957.json")
    firebase_admin.initialize_app(cred)


def read_data(_q_collection, _q_doc):

    db = firestore.client()

    doc_ref = db.collection(_q_collection).document(_q_doc)

    doc = doc_ref.get()
    if doc.exists:
        return doc.to_dict()
    else:
        return 0


def add_data():
    db = firestore.client()

    data = {
        "area": "Colombo",
        "r": "x1101001",
        "739076": {"1": "P311", "4": "P301", "2": "P338", "3": "P382"},
        "739077": {"2": "P338"},
        "739078": { "4": "P301", "2": "P338"},
        "739079": {"1": "P311", "3": "P391"},
        "739080": {"1": "P311", "4": "P301", "2": "P338", "3": "P382"},
        "739081": {"1": "P311", "4": "P301", "2": "P338", "3": "P382"},
        "739082": {"1": "P311", "4": "P301", "2": "P338", "3": "P382"},
        "739083": {},
        "739084": {"2": "P338"},
        "739085": {"1": "P311"},
        "739086": {"4": "P301", "2": "P338"},
        "739087": {"2": "P338"},
        "739088": {"1": "P311", "3": "P391", "4": "P301", "2": "P338"},
        "739089": {},
        "739090": {"4": "P301", "2": "P338"},
        "739091": {"2": "P338"},
        "739092": {"4": "P301", "2": "P338"},
        "739093": {},
        "739094": {},
        "739095": {},
        "739096": {},
        "739097": {},
        "739098": {},
        "739099": {},
        "739100": {},
        "739101": {},
        "739102": {},
        "739103": {},
        "739104": {}
    }

    db.collection("mwf_schedules").document("247467").set(data)



def update(_collection, _document, update_string):
    db = firestore.client()
    query = db.collection(_collection).document(_document)
    query.set(update_string, merge=True)
    
    return "done"

def query_field_list_orderby(_collection, field, field_val, orderby):
    db = firestore.client() 
    query_db = db.collection(_collection)

    query = query_db.where(filter = FieldFilter(field, "==", field_val)).order_by(orderby, direction=firestore.Query.DESCENDING)
    docs = query.stream()
    output = []

    for doc in docs:
        output.append({doc.id: doc.to_dict()})
        
    return output

def query_field_list(_collection, field, field_val):
    db = firestore.client() 
    query_db = db.collection(_collection)

    query = query_db.where(filter = FieldFilter(field, "==", field_val))
    docs = query.stream()
    output = []

    for doc in docs:
        output.append({doc.id: doc.to_dict()})
        
    return output

def query_field_list_mulcond(_collection, field1, field1_val, field2, field2_val):
    db = firestore.client() 
    query_db = db.collection(_collection)

    query = query_db.where(filter = FieldFilter(field2, "==", field2_val)).where(filter = FieldFilter(field1, "==", field1_val))
    docs = query.stream()
    output = []

    for doc in docs:
        output.append({doc.id: doc.to_dict()})
        
    return output

def query_onefield(_collection, field, field_val):
    db = firestore.client() 
    query_db = db.collection(_collection)

    query = query_db.where(filter = FieldFilter(field, "==", field_val))
    docs = query.stream()
    output = []

    for doc in docs:
        output.append(doc.id)
        
    return output

def get_a_doc(_collection, _doc_id):
    db = firestore.client() 
    query_db = db.collection(_collection).document(_doc_id)

    doc = query_db.get()

    if doc.exists:
        return doc.to_dict()
    else:
        return 0


def insert_doc(_collection, _doc_id, _content):
    db = firestore.client()
    db.collection(_collection).document(_doc_id).set(_content)

def insert_doc_auto(_collection, _content):
    db = firestore.client()
    db.collection(_collection).add(_content)

def delete_doc(_collection, _docid):
    db = firestore.client()
    db.collection(_collection).document(_docid).delete()