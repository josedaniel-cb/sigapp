import 'package:SIGApp/browser/scraper.dart';

class Scripts{
  static String browserSolicitarDocumento(){
    return '''
      (function() {
        return document.getElementsByTagName('html')[0].outerHTML;
      })();
    ''';
  }

  // Login
  static String loginSolicitarIngreso(String? cu, String? password){
    return '''
      document.getElementById('CodAlumno').value = '$cu';
      document.getElementById('ClaveWeb').value = '$password';
      document.getElementsByTagName('button')[0].click();
    '''
    ;
  }

  // Boletin
  static String boletinClickNotas(int indexCurso){
    return '''
      javascript: document.getElementsByTagName('${Scraper.tagCuerpoTabla}')[0].getElementsByTagName('${Scraper.tagFilaTabla}')[$indexCurso].getElementsByTagName('a')[0].click();
    ''';
  }
  
  // General
  static String genericSeleccionarSemestre(int? indexSemestre){
    // return '''
    //   document.getElementById("semestres").options[$indexSemestre].selected = true;
    //   document.getElementsByClassName("k-icon k-i-refresh")[0].click();
    // ''';
    return '''
      document.getElementById('semestres').options[$indexSemestre].selected = true;
      document.getElementsByClassName('${Scraper.classIconRefresh}')[0].click();
    ''';
  }
}