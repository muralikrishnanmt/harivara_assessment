class AppServices {
  String checkError(String errorCode) {
    if (errorCode == '410') {
      return 'Unable to select as Max No of Alphabet reached';
    } else if (errorCode == '411') {
      return 'Unable to select as Max No of Numbers reached';
    } else if (errorCode == '412') {
      return 'Unable to select as Max No of Selections reached';
    } else if (errorCode == '413') {
      return 'You cannot enter value more than 18 in Max no of selections';
    } else if (errorCode == '414') {
      return 'You cannot enter value more than 11 in Max no of Alphabets';
    } else if (errorCode == '415') {
      return 'You cannot enter value more than 11 in Max no of Numbers';
    } else if (errorCode == '416') {
      return 'Only max of 11 select boxes can be created, enter value less than or equal to 11';
    } else {
      return '';
    }
  }
}
