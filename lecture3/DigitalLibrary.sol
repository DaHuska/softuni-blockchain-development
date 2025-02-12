// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

enum Status {
    Active, Outdated, Archived
}

struct EBook {
    string title;
    string author;
    uint256 publicationDate;
    uint256 expirationDate;
    Status status;
    address primaryLibrarian;
    uint256 readCount;
}

contract DigitaLibrary {
    EBook[] public books;
    address[] public librarians;

    function createEBook(string memory _title, string memory _author, uint256 _publicationDate) external {
        books.push(EBook({
            title: _title,
            author: _author,
            publicationDate: _publicationDate,
            expirationDate: _publicationDate + 180,
            status: Status.Active,
            primaryLibrarian: msg.sender,
            readCount: 0
        }));
    }

    function addLibrarian(address _librarian) external {
        librarians.push(_librarian);
    }
}