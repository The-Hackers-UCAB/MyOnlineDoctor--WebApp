///Genre: enum for genre
enum Genre {
  male,
  female
}


extension GenreType on Genre{

  String get genre {

    switch(this){

      case Genre.male:
        return 'Hombre';

      case Genre.female:
        return 'Mujer';

    }

  }
}