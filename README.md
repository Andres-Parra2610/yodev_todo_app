# Flutter Todo App with BLoC and Firestore

This is a task management (Todo App) developed in Flutter using the BLoC pattern for state management and Firestore as the backend database.

## Repository Structure

The repository is organized into several main folders:

- **blocs**: Contains the BLoCs (Business Logic Components) used in the application.
  - `todo_bloc.dart`: Defines the BLoC to handle task operations.
  - `todo_event.dart`: Defines the events that the task BLoC can process.
  - `todo_state.dart`: Defines the states in which the task BLoC can be.

- **cubit**: Implementation of the Cubit pattern to filter tasks.
  - `todo_filter_cubit.dart`: Cubit that manages the task filter state.

- **core**:
  - `enums.dart`: Enumerations used throughout the application.
  - `helpers.dart`: Helper functions used in various parts of the app.

- **data**:
  - **repositories/todo**:
    - `todo_repository.dart`: Repository that handles data access logic for tasks.

- **ui**:
  - **screens** and **widgets**: Contain the widgets and screens used in the application.
  - `main.dart`: The main file that starts the application.

## Features

- Task management using Firestore.
- Task filtering (all, completed, not completed).
- Use of the BLoC pattern to separate business logic from the user interface.

## Configuration

To run this application, you will need to have Flutter installed on your machine. Clone this repository and at the project root execute:

```bash
flutter pub get
flutter run
