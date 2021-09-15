trigger checkphobe on Contact (before insert,before update)  {
         for(Contact c : trigger.new)
         {
             if (c.phone=='110') {
                 c.phone='119';
             }
             if (c.phone=='112') {
                c.addError('错误的电话号码');
             }
         } 
          
        
    }
        
