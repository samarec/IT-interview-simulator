from pydantic import BaseModel
from typing import List


class TagResponse(BaseModel):
    id: int
    name: str

    class Config:
        from_attributes = True


class TopicResponse(BaseModel):
    id: int
    name: str
    tags: List[TagResponse]
    cards_count: int

    class Config:
        from_attributes = True