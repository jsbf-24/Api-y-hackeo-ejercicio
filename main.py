from fastapi import FastAPI, HTTPException
from sqlmodel import SQLModel, Field
from typing import Optional

app = FastAPI(title="API DE JUAN")

#funciones de usuarios y modificación
class User(SQLModel):
    id: int | None =None
    username: str
    password: str
    email: str | None = None
    is_active: bool = True


class UserUpdate(SQLModel):
    username: Optional[str] = None
    password: Optional[str] = None
    email: Optional[str] = None
    is_active: Optional[bool] = None

#"base de datos"
users_db: list[User] = []
next_id = 1

#endpoints
@app.get("/")
def root():
    return {"message": "API con SQLModel (sin BD externa)"}


@app.post("/users", response_model=User)
def create_user(user: User):
    global next_id

    # usuario único
    for u in users_db:
        if u.username == user.username:
            raise HTTPException(status_code=400, detail="El username ya existe")

    user.id = next_id
    next_id += 1
    users_db.append(user)
    return user


@app.get("/users", response_model=list[User])
def list_users():
    return users_db


@app.get("/users/{user_id}", response_model=User)
def get_user(user_id: int):
    for u in users_db:
        if u.id == user_id:
            return u
    raise HTTPException(status_code=404, detail="Usuario no encontrado")


@app.put("/users/{user_id}", response_model=User)
def update_user(user_id: int, user_update: UserUpdate):
    for u in users_db:
        if u.id == user_id:
            # Actualizar campos, no se puede editar la contraseña
            if user_update.username is not None:
                u.username = user_update.username
            if user_update.email is not None:
                u.email = user_update.email
            if user_update.is_active is not None:
                u.is_active = user_update.is_active
            return u
    raise HTTPException(status_code=404, detail="Usuario no encontrado")


@app.delete("/users/{user_id}")
def delete_user(user_id: int):
    for u in users_db:
        if u.id == user_id:
            users_db.remove(u)
            return {"message": "Usuario eliminado"}
    raise HTTPException(status_code=404, detail="Usuario no encontrado")

@app.get("/login") 
@app.post("/login")
def login(username: str, password: str):
    for u in users_db:
        if u.username == username and u.password == password:
            return {"message": "Login exitoso", "user": u.username}
    raise HTTPException(status_code=401, detail="Credenciales inválidas")

#jsbf-24