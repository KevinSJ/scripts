function gmailAutoarchive() {
  var maxDate = new Date();
  maxDate.setDate(maxDate.getDate()); // what was the date at that time?
  var threads = GmailApp.getInboxThreads();
  for(var i in threads){
    var thread = threads[i];
    if (thread.getLastMessageDate()<maxDate){
      thread.moveToArchive();
    }
  }
}
