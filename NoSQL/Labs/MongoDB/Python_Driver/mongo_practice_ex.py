from pymongo import MongoClient
user = 'root'
password = 'NDAyNS1jcmFpZ3Ry' # yourpw
host='localhost'
#create the connection url
connecturl = "mongodb://{}:{}@{}:27017/?authSource=admin".format(user,password,host)


# connect to mongodb server
print("Connecting to mongodb server")
connection = MongoClient(connecturl)

# select/create the 'training' database 
training_db = connection.training 

# select/create a collection named mongodb_glossary
mng_db_glsry = training_db.mongodb_glossary

# insert a few documents into created collection
mng_db_insertMany = [{"database": "a database named collections"}, 
                    {"collection": "a collection stores the documents"},
                    {"document":"a document contains the data in the form of key value pairs"}]

# insert the above documents 
mng_db_glsry.insert_many(mng_db_insertMany)

# Query and print all documents in the training db and mongodb_glossary collection
glossary_docs = mng_db_glsry.find()

for doc in glossary_docs:
    print(doc)

# close connection
print("Closing the connection")
connection.close()
