

  MEMBER('LSL_Calculator')

OMIT('***')
 * Created with Clarion 11.1
 * User: obrunker
 * Date: 7/08/2025
 * Time: 11:11 AM
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 ***

  MAP
CalculateDays           function(long StartDate, long EndDate),long
CalculateWeeks          function(long StartDate, long EndDate),long
CalculateMonths         function(long StartDate, long EndDate),long
CalculateYears          function(long StartDate, long EndDate),long
  END


TimeSpan            function(long StartDate, long EndDate, string SpanType)
    code
        case SpanType
        of SPANTYPE:Days
            return(CalculateDays(StartDate, EndDate))
        of SPANTYPE:Weeks
            return(CalculateWeeks(StartDate, EndDate))
        of SPANTYPE:Months
            return(CalculateMonths(StartDate, EndDate))
        of SPANTYPE:Years
            return(CalculateYears(StartDate, EndDate))
        end
        
        return 0
            
CalculateDays       function(long StartDate, long EndDate)
    code
        return(EndDate - StartDate)
        
CalculateWeeks          function(long StartDate, long EndDate)
    code
        return(int(CalculateDays(StartDate, EndDate) / 7))
        
CalculateMonths     function(long StartDate, long EndDate)
Years                   long
returnValue             long
StartDateMonth          long
EndDateMonth            long
    code
        Years = CalculateYears(StartDate, EndDate)
        returnValue = Years * 12
        
        StartDateMonth = month(StartDate)
        EndDateMonth   = month(EndDate)
        if StartDateMonth > EndDateMonth
            returnValue += ((12 - StartDateMonth) + EndDateMonth)
            if day(EndDate) < day(StartDate)
                returnValue -= 1
            end
        elsif StartDateMonth < EndDateMonth
            returnValue += (EndDateMonth - StartDateMonth)
            if day(EndDate) < day(StartDate)
                returnValue -= 1
            end
        elsif StartDateMonth = EndDateMonth
            if day(EndDate) < day(StartDate)
                returnValue += 11
            end
        end
        
        return(returnValue)
        
CalculateYears          function(long StartDate, long EndDate)
returnValue             long
    code
        returnValue = year(EndDate) - year(StartDate)
        
        ! As per suggestion by Carl Barns
        if returnValue > 0
            case month(EndDate) - month(StartDate)
            of -12 to -1
                returnValue -= 1
            of 0
                if day(EndDate) < day(StartDate)
                    returnValue -= 1
                end
            end
        end
        
        return(returnValue)
    
