# Books overview

##Swift:

###LibraryTableViewController
Root view controller (within a nav). Displays all books currently in the library. Decided to make it a singleton to make interaction between controllers easy. Making it a singleton is fine since this controller will always exist in the nav controller stack and will always be the same instance.

###LibraryTableViewCell
 Custom table view cell that shows each book's title and author in the LibraryTableViewController. 

###Book 
Book model. Contains all data for a specific book.

###BookStore
Singleton Book data store. Handles all updating, deleting, and creating of books, and keeps track of all the books currently in the library.

###User
The current user. Is a singleton. Automatically loads the user's name if available when first instantiated, and saves it when obtained.

###NetworkManager
Class that makes network requests simple. Uses AFNetworking.
Decided to use AFNetworking over other networking libraries since I was more familiar with it, and bridging it to Swift was easy.

###CheckoutNameViewController
View controller that handles asking for user's name when required.

###AddBookViewController
Handles creating a new book, as well as editing an existing book.


##Objective-C:

###SREButton
custom UIButton subclass that provides nice highlighting animations and other methods to make buttons more visually appealing


