# diamond_report

Diamond Report

## Getting Started

## Screen 1.
There are 2 buttons in the screen 
1. Load excel data from the storage.
2. Load data from dart file

the file reading logic is different but later operation logic is same.
once the file is loaded from the storage it reads the filter data such as lab, shape, color, clarity from the file itself.
even if the a new type is added to any of the filtering data no need to update the data in the code because it takes the data from the file.

In filter screen there are 2 buttons clear and search.
clear button clears the filter and search button is used to search the diamond report.

## Screen 2.
Once the search is done, it navigates to list screen, where we can find all the filtered list.
if no filter is applied, every data will be displayed.

in appbar there are 2 buttons sort and cart
sort button shows the sorting items where we can sort the list.
cart button navigates us to cart screen where the items added to cart will be displayed.

in the list add and remove button will be there
initially the add button will be displayed
once the item is added to cart add button will be hidden and remove button will be displayed.

## Screen 3.
In cart screen the list of items are displayed which is added to cart.
in the list remove button is there which is used to remove the item from the cart.


## Technical usage
1. where running the code run below command
    dart run build_runner build --delete-conflicting-outputs

2. Bloc state management is used.
    related library
        flutter_bloc: ^9.1.0
        equatable: ^2.0.7
        freezed_annotation: ^2.0.0
3. Shared preference is used to save the cart items.
    only the list of lot id is stored in cache.
    the cart item is fetched based on the stored lot id in the cached.

## Widgets
In widgets folder there widgets which has been re used in the entire application.
this is easy to manage and maintain the code.
