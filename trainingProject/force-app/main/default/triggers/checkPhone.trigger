trigger checkPhone on Contact (before delete, before insert, before update, 
after delete, after insert, after update, after undelete) {
    if (trigger.isupdate) {
        if (trigger.isbefore ) {
            for (contact  con  : trigger.new ) {
                if(con.phone=='110'){
                    con.phone='119';
                }
                if (con.phone=='112') {
                    con.addError('错误的电话号码');
                }
            }
        }
    }
    if (trigger.isinsert) {
        if (trigger.isbefore ) {
            for (contact  con  : trigger.new ) {
                if(con.phone=='110'){
                    con.phone='119';
                }
                if (con.phone=='112') {
                    con.addError('错误的电话号码');
                }
            }
        }
    }

}