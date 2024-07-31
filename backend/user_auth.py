import db_ops as dbase

def authenticate_users(username, password):
    doc_from_dbase = dbase.get_a_doc('user_authentication', username)

    if(doc_from_dbase['password'] == password):
        _role = doc_from_dbase['role']
        return _role
    else:
        return "NOOK"
    

def register_user(uname, email, password):
    data ={"name": uname, "password": password, "role": "PNT"}
    dbase.insert_doc("user_authentication",email,data)
    return "ok"