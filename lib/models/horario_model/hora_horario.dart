class HoraHorario{
  // Formato de 24 horas
  final int horas;
  final int minutos;

  HoraHorario(this.horas, this.minutos);
  
  @override
  String toString(){
    if(horas == 0){
      return '12:${_completarCero(minutos)} AM';
    } else if(horas == 12){
      return '12:${_completarCero(minutos)} PM';
    } else if(horas > 12){
      return '${_completarCero(horas - 12)}:${_completarCero(minutos)} PM';
    } else {
      return '${_completarCero(horas)}:${_completarCero(minutos)} AM';
    }
  }

  String _completarCero(int n){
    String s = n.toString();
    if(s.length < 2){
      s = '0$s';
    }
    return s;
  }
}