#!/usr/bin/python3
""" State Module for HBNB project """
from models.base_model import BaseModel, Base
from sqlalchemy import Column, String, ForeignKey
from sqlalchemy.orm import relationship
from os import getenv

storage_type = getenv("HBNB_TYPE_STORAGE")


if storage_type == "db":
    class State(BaseModel, Base):
        """ State class """
        __tablename__ = 'states'
        id = Column(String(60), primary_key=True)

        if getenv("HBNB_TYPE_STORAGE") == "db":
            cities = relationship('City', cascade="all,delete", backref="state")
else:
    class State(BaseModel):
        """ State class """
        name = ""
        @property
        def cities(self):
            """getter for cities related to this state"""
            from models import storage
            citiesList = []
            citiesAll = storage.all(City)
            for city in citiesAll.values():
                if city.state_id == self.id:
                    citiesList.append(city)
            return citiesList
