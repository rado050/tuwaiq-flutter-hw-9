import 'dart:io'; //To take input and output from the console
import 'package:books/sold_Book.dart';
import 'package:collection/collection.dart';
import 'package:books/book.dart';

class BookList {
  static List<Book> books = [];  //"static" to be global and constract
  //static double vat = 0.15;
  static Map<DateTime, List<SoldBook>> invoices = {};
  static int lastID = 0; //// id must to start from zero because when we add or remove a book it will save the id number for it and can not any book has the same id
  static viewAllBooks() { // function for print all books together
    print(
        '|--ID--|---------Book Title---------|----------Author----------|--Price--|-Quantity-|');
    if (books.isNotEmpty) { // to check the list to be sure there are books
      books.forEach((element) { // to pass over and view all the elements .
        element.view();
      });
    } else {
      print("No Books Found".padLeft(45)); // print the statement in the middle of line(padleft)
    }
  }

  static add() {  //create a function for add a book
    String? readLineString;
    do {
      String? titleReadLineString;
      while (titleReadLineString == null || titleReadLineString.isEmpty) {
        stdout.write("Enter a valid Title : "); // will block the program until the output is written
        titleReadLineString = stdin.readLineSync(); //method used to take input from the user
        if (titleReadLineString != null) {
          titleReadLineString = titleReadLineString.trim();
        }
      }
      String? authorReadLineString;
      while (authorReadLineString == null || authorReadLineString.isEmpty) {
        stdout.write("Enter a valid Author : ");
        authorReadLineString = stdin.readLineSync();
        if (authorReadLineString != null) {
          authorReadLineString = authorReadLineString.trim();
        }
      }
      String? priceReadLineString;
      double? price;
      while (price == null) {
        stdout.write("Enter a valid Price : ");
        priceReadLineString = stdin.readLineSync();
        if (priceReadLineString != null) {
          priceReadLineString = priceReadLineString.trim();
          price = double.tryParse(priceReadLineString); // convert string input to double 
        }
      }
      String? quantityReadLineString;
      int? quantity;
      while (quantity == null) {
        stdout.write("Enter a valid Quantity : ");
        quantityReadLineString = stdin.readLineSync();
        if (quantityReadLineString != null) {
          quantityReadLineString = quantityReadLineString.trim();
          quantity = int.tryParse(quantityReadLineString); //convert string input to integer 
        }
      }
      lastID++; // after writing everything it will add id by one , to be unique
      Book book = Book(
          book_id: lastID,
          book_title: titleReadLineString,// save the input title in book title 
          author: authorReadLineString,// save the input author in  author 
          price: price, // we saved iquantityReadLineString in "price" befor ,so now we just add price to the price object
          quantity: quantity);// same price 
      books.add(book); // to add the input book to the our library

      readLineString = null;
      print("Do you want to Add another Book [Y] for Yes or [N] for No : ");
      while (readLineString != "Y" && readLineString != "N") { // if the user write Y or N it will save the input into "readLineString" // if the user write Y or N it will save the input into "readLineString" 
        readLineString = stdin.readLineSync();
        if (readLineString != null) { // if the enteries not Null do the next
          readLineString = readLineString.trim(); // delete spaces from the enteres sides.
        }
      }
    } while (readLineString != "N"); // to Continue adding books untill press [N]
  }

  static edit() { // create a function to edit an element in the librery 
    String? readLineString;
    int? bookID;
    Book? book;
    do {
      BookList.viewAllBooks();// at first we will show all the books to choose the book that the user can to make changes on it 
      print("Enter a valid Book ID to Edit or [^E] to Exit : ");
      readLineString = stdin.readLineSync(); // save the input id to the " readLineString"
      if (readLineString != null) {
        readLineString = readLineString.trim();
        bookID = int.tryParse(readLineString); // convert the string input to integer and save it in bookID
      }
      if (bookID != null) {
        book = books.firstWhereOrNull((element) => element.book_id == bookID);
      }

      while (readLineString != "^E" && readLineString != "^C" && book != null) { // راح يعرض له الكتاب اللب يبي يعدله عليه اذا ماكانت القيمه اللي دخلها E or C 
        print("The Book you choose is :");
        print(
            '|--ID--|---------Book Title---------|----------Author----------|--Price--|-Quantity-|');
        book.view();
        print(
            "Enter a valid number (1-4) to Edit the following, [^C] to Choose another book or [^E] to Exit :");
        print("1 - Title");
        print("2 - Author");
        print("3 - Price");
        print("4 - Quantity");
        readLineString = stdin.readLineSync(); // To read the input from user and save it in "readLineString"
        if (readLineString != null) {
        if (readLineString != null) {
          readLineString = readLineString.trim();
        }
        String? switchReadLineString;
        switch (readLineString) {
          case "1":
            while (
                switchReadLineString == null || switchReadLineString.isEmpty) {
              stdout.write("Enter a valid New Title (${book.book_title}) : "); // user must add a book title to change the book title
              switchReadLineString = stdin.readLineSync();
              if (switchReadLineString != null) {
                switchReadLineString = switchReadLineString.trim();
              }
            }
            book.book_title = switchReadLineString;
            break;
          case "2":
            while (
                switchReadLineString == null || switchReadLineString.isEmpty) {
              stdout.write("Enter a valid New Author (${book.author}) : "); // to edit author name
              switchReadLineString = stdin.readLineSync(); // user can enter a new  author name 
              if (switchReadLineString != null) {
                switchReadLineString = switchReadLineString.trim();
              }
            }
            book.author = switchReadLineString;
            break;
          case "3":
            double? price;
            while (price == null) {
              stdout.write("Enter a valid New Price (${book.price}) :"); // if the user want to change price;
              switchReadLineString = stdin.readLineSync();
              if (switchReadLineString != null) {
                switchReadLineString = switchReadLineString.trim();
                price = double.tryParse(switchReadLineString);
              }
            }
            book.price = price;
            break;
          case "4":
            int? quantity;
            while (quantity == null) {
              stdout.write("Enter a valid New Quantity (${book.quantity}) : ");
              switchReadLineString = stdin.readLineSync(); // recevie a new quantity entry.
              if (switchReadLineString != null) {
                switchReadLineString = switchReadLineString.trim();
                quantity = int.tryParse(switchReadLineString);
              }
            }
            book.quantity = quantity;
            break;
          default:
            break;
        }
      }
    } while (readLineString != "^E");
  }

  static delete() {
    String? readLineString;
    int? bookID;
    Book? book;
    do {
      BookList.viewAllBooks(); // to wiew all the books for users.
      print("Enter a valid Book ID to Delete or [^E] to Exit : "); // choose the book to delete it;
      readLineString = stdin.readLineSync();
      if (readLineString != null) {
        readLineString = readLineString.trim();
        bookID = int.tryParse(readLineString);
      }
      if (bookID != null) {
        book = books.firstWhereOrNull((element) => element.book_id == bookID); // method that search of element by the index 
      }
      if (book != null) {
        print("The Book you choose is :");
        print(
            '|--ID--|---------Book Title---------|----------Author----------|--Price--|-Quantity-|');
        book.view();
        print(
            "Are you sure you want to delete it enter [Y] for yes or [N] for no");
        while (readLineString != "Y" && readLineString != "N") {
          readLineString = stdin.readLineSync();
          if (readLineString != null) {
            readLineString = readLineString.trim();
          }
        }
        if (readLineString == "Y") {
          books.remove(book); //if he choose Y it will delete the book
          print("Book Deleted"); // then print this statement
        }
      }
    } while (readLineString != "^E");
  }

  static search() {
    String? readLineString;
    int? bookID;
    List<Book> searchResult = [];
    while (readLineString != "^E") {
      print(
          "Enter a valid number (1-4) from the following to search by or [^E] to Exit : ");
      print("1 - Book ID");
      print("2 - Title");
      print("3 - Author");
      print("4 - All");
      readLineString = stdin.readLineSync();
      if (readLineString != null) {
        readLineString = readLineString.trim();
      }
      String? switchReadLineString;
      switch (readLineString) {
        case "1":
          while (switchReadLineString != "^E" && switchReadLineString != "^C") {
            print(
                "Enter a Book ID to search for, [^C] to Choose another Category or [^E] to Exit : ");
            switchReadLineString = stdin.readLineSync();
            if (switchReadLineString != null) {
              switchReadLineString = switchReadLineString.trim();
            }
            if (switchReadLineString == "^E") {
              readLineString = switchReadLineString;
            }
            if (switchReadLineString != null) {
              bookID = int.tryParse(switchReadLineString); // convert the string input to int and save it in bookID
            }
            if (bookID != null) {
              searchResult =
                  books.where((element) => element.book_id == bookID).toList();
              print("Search Result are : ${searchResult.length}");
              print(
                  '|--ID--|---------Book Title---------|----------Author----------|--Price--|-Quantity-|');
              if (searchResult.isNotEmpty) {
                for (var element in searchResult) {
                  element.view();
                }
              } else {
                print("No Books Found".padLeft(45));
              }
            }
          }
          break;
        case "2":
          while (switchReadLineString != "^E" && switchReadLineString != "^C") { 
            print(
                "Enter a Book Title to search for, [^C] to Choose another Category or [^E] to Exit : ");
            switchReadLineString = stdin.readLineSync();// search a book but by title 
            if (switchReadLineString != null) {
              switchReadLineString = switchReadLineString.trim();
            }
            if (switchReadLineString == "^E") {
              readLineString = switchReadLineString;
            }
            if (switchReadLineString != null &&
                switchReadLineString != "^E" &&
                switchReadLineString != "^C") {
              searchResult = books
                  .where((element) =>
                      element.book_title.contains(switchReadLineString!))
                  .toList();
              print("Search Result are : ${searchResult.length}");
              print(
                  '|--ID--|---------Book Title---------|----------Author----------|--Price--|-Quantity-|');
              if (searchResult.isNotEmpty) {
                for (var element in searchResult) {
                  element.view();
                }
              } else {
                print("No Books Found".padLeft(45));
              }
            }
          }
          break;
        case "3":
          while (switchReadLineString != "^E" && switchReadLineString != "^C") {
            print(
                "Enter a Book Author to search for, [^C] to Choose another Category or [^E] to Exit : ");
            switchReadLineString = stdin.readLineSync();
            if (switchReadLineString != null) {
              switchReadLineString = switchReadLineString.trim();
            }
            if (switchReadLineString == "^E") {
              readLineString = switchReadLineString;
            }
            if (switchReadLineString != null &&
                switchReadLineString != "^E" &&
                switchReadLineString != "^C") {
              searchResult = books
                  .where((element) =>
                      element.author.toString().contains(switchReadLineString!))
                  .toList();
              print("Search Result are : ${searchResult.length}");
              print(
                  '|--ID--|---------Book Title---------|----------Author----------|--Price--|-Quantity-|');
              if (searchResult.isNotEmpty) {
                for (var element in searchResult) {
                  element.view();
                }
              } else {
                print("No Books Found".padLeft(45));
              }
            }
          }
          break;
        case "4":
          while (switchReadLineString != "^E" && switchReadLineString != "^C") {
            print(
                "Enter a search , [C] to Choose another Category or [E] to Exit : ");
            switchReadLineString = stdin.readLineSync();
            if (switchReadLineString != null) {
              switchReadLineString = switchReadLineString.trim();
              if (switchReadLineString == "^E") {
                readLineString = switchReadLineString;
              }
              bookID = int.tryParse(switchReadLineString);
            } else {
              switchReadLineString = "";
            }
            if (switchReadLineString != "^E" && switchReadLineString != "^C") {
              searchResult = books
                  .where((element) =>
                      element.book_id == bookID ||
                      element.book_title.contains(switchReadLineString!) ||
                      element.author.toString().contains(switchReadLineString))
                  .toList();
              print("Search Result are : ${searchResult.length}");
              print(
                  '|--ID--|---------Book Title---------|----------Author----------|--Price--|-Quantity-|');
              if (searchResult.isNotEmpty) {
                for (var element in searchResult) {
                  element.view();
                }
              } else {
                print("No Books Found".padLeft(45));
              }
            }
          }
          break;
        default:
          break;
      }
    }
  }

  static sell() {
    String? readLineString;
    Book? book;
    Map<int, SoldBook> soldBooks = {};
    List<SoldBook> soldBookList = [];
    Map<int, Book> originalBookList = {};
    int errorCode =
        0; //error code 1 mean id is wrong, error code 2 mean we don't have the quantity, error code 3 mean quantity is wrong
    do {
      soldBookList.clear();
      originalBookList.clear();
      if (errorCode == 1) {
        print("One of the Book IDs you Entered is Wrong!!");
      }
      if (errorCode == 2) {
        print("Sorry! we are out of stock");
      }
      if (errorCode == 3) {
        print("One of the Book quantity you Entered is Wrong!!");
      }
      errorCode = 0;
      print("Available Books : ");
      BookList.viewAllBooks();
      print(
          'Enter a valid Book ID followed by ":" then the quantity (default 1 if not specified) and separated by "," for each book Example(1:5,2:,7) or [^E] to Exit : ');
      readLineString = stdin.readLineSync();
      if (readLineString != null) {
        readLineString = readLineString.trim();
      }
      if (readLineString != null) {
        for (var bookWithQuantity in readLineString.split(",")) {
          var bookInfo = bookWithQuantity.split(":");
          book = books.firstWhereOrNull(
              (element) => element.book_id == int.tryParse(bookInfo[0].trim()));
          if (book == null) {
            errorCode = 1;
            break;
          } else {
            var reqQuantity = 1;
            if (bookInfo.length > 1) {
              if (bookInfo[1] != "") {
                var parsedQuantity = int.tryParse(bookInfo[1].trim());
                if (parsedQuantity != null) {
                  reqQuantity = parsedQuantity;
                } else {
                  errorCode = 3;
                  break;
                }
              }
            }
            if (book.quantity < reqQuantity) {
              errorCode = 2;
              break;
            }
            if (errorCode == 0) {
              SoldBook soldBook = SoldBook(
                  title: book.book_title,
                  price: book.price,
                  quantity: reqQuantity);
              soldBookList.add(soldBook);
              originalBookList.addAll({reqQuantity: book});
            }
          }
        }
      }
      if (soldBookList.isNotEmpty && errorCode == 0) {
        print("The Book you choose are :");
        print(
            '|--ID--|---------Book Title---------|----------Author----------|--Price--|-Quantity-|');
        for (var element in originalBookList.entries) {
          //element.view();
          String printID = element.value.book_id.toString();
          if (printID.length < 5) {
            printID = " " * ((5 - printID.length) ~/ 2) + printID;
          }
          printID = printID.padRight(5);
          //-----
          String printTitle = element.value.book_title;
          if (printTitle.length < 26) {
            printTitle = " " * ((26 - printTitle.length) ~/ 2) + printTitle;
          }
          printTitle = printTitle.padRight(26);
          if (printTitle.length > 26) {
            printTitle = "${printTitle.substring(1, 24)}...";
          }
          //-------
          String printAuthor = element.value.author;
          if (printAuthor.length < 24) {
            printAuthor = " " * ((24 - printAuthor.length) ~/ 2) + printAuthor;
          }
          printAuthor = printAuthor.padRight(24);
          if (printAuthor.length > 24) {
            printAuthor = "${printAuthor.substring(1, 22)}...";
          }
          //-------
          String printPrice = element.value.price.toString();
          if (printPrice.length < 7) {
            printPrice = " " * ((7 - printPrice.length) ~/ 2) + printPrice;
          }
          printPrice = printPrice.padRight(7);
          //-------
          String printQuantity = element.key.toString().padLeft(4, "0");
          if (printQuantity.length < 9) {
            printQuantity =
                " " * ((9 - printQuantity.length) ~/ 2) + printQuantity;
          }
          printQuantity = printQuantity.padRight(9);
          print(
              "|$printID | $printTitle | $printAuthor | $printPrice | $printQuantity|");
        }

        print("Are you sure you want to Buy enter [Y] for yes or [N] for no");
        while (readLineString != "Y" && readLineString != "N") {
          readLineString = stdin.readLineSync();
          if (readLineString != null) {
            readLineString = readLineString.trim();
          }
        }
        if (readLineString == "Y") {
          for (var element in originalBookList.entries) {
            element.value.quantity -= element.key;
          }
          DateTime invoiceDate = DateTime.now();
          double totalAmount = 0;
          print('''  
                   
   Date : ${invoiceDate.year}/${invoiceDate.month}/${invoiceDate.day}                                       time : ${invoiceDate.hour}:${invoiceDate.minute}
   ''');
          print(
              '|---------Book Title---------|---Quantity---|---Unit Price---|----Total----|');
          for (var element in soldBookList) {
            element.view();
            totalAmount += element.total;
          }
          print('''
                                           _______________________________
                                           | Total Amount         $totalAmount  |
    ''');
          invoices.addAll({invoiceDate: soldBookList});
        }
      }
    } while (readLineString != "^E");
  }
}
