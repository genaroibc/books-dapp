// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

contract BookContract {
    constructor() {
        createBook(
            "Lord of the Rings",
            "The Lord of the Rings is the saga of a group of sometimes reluctant heroes who set forth to save their world from consummate evil. Its many worlds and creatures were drawn from Tolkien's extensive knowledge of philology and folklore.",
            "J.R.R. Tolkien"
        );
    }

    struct Book {
        uint id;
        string title;
        string author;
        string description;
        uint createdAt;
    }

    mapping(uint => Book) public books;

    uint public booksCount = 0;

    event BookCreated(uint id, string title, string author, string description);

    function createBook(
        string memory _title,
        string memory _description,
        string memory _author
    ) public {
        books[booksCount] = (
            Book({
                id: booksCount,
                title: _title,
                author: _author,
                description: _description,
                createdAt: block.timestamp
            })
        );

        emit BookCreated(booksCount, _title, _author, _description);

        booksCount++;
    }

    function updateBook(
        uint _id,
        string memory _title,
        string memory _description,
        string memory _author
    ) public {
        uint index = findBookIndex(_id);

        books[index].title = _title;
        books[index].description = _description;
        books[index].author = _author;
    }

    function deleteBook(uint _id) public {
        uint index = findBookIndex(_id);

        delete books[index];
    }

    function findBookIndex(uint _id) public view returns (uint) {
        for (uint i = 0; i < booksCount; i++) {
            if (books[i].id == _id) {
                return i;
            }
        }

        revert("Book not found");
    }
}
