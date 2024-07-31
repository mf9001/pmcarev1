import db_ops as dbase
import datetime as dt

def add_growth_entry(ptnid, stime, parameter, amount, unit, note):
#2024-07-20 17:32:18.525578 <- Drt format
#receving format 2024-07-26 12:07

    
    data = {"pntid": ptnid, "stime": stime, "parameter": parameter, "amount": amount, "unit": unit, "calc_prec": "75", "note": note}
    dbase.insert_doc_auto("growth_track", data)
    return "ok"


def get_growth_records(ptnid, paramid):
    content = dbase.query_field_list_mulcond("growth_track", "pntid", ptnid, "parameter", paramid)

    array_collector = []  
    i = 0 

    for x in content:
        first_index = list(x.keys())[0]
        y = x[first_index]
        y["recid"]=i
        y["docid"]=first_index
        i = i + 1
        array_collector.append(y)    

    return array_collector


def delete_a_growth_record(__docid):
    dbase.delete_doc('growth_track',__docid)
    return "OK"