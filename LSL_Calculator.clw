
  PROGRAM

OMIT('***')
 * Created with Clarion 12.0
 * User: obrunker
 * Date: 5/08/2025
 * Time: 10:50 AM
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 ***

SPANTYPE:Days       equate('DAYS')
SPANTYPE:Weeks      equate('WEEKS')
SPANTYPE:Months     equate('MONTHS')
SPANTYPE:Years      equate('YEARS')


                    MAP
                        module('LslCalculatorUI.clw')
CalculatorUILSL             procedure()

                        end
                        module('TimespanCalcs.clw')
TimeSpan                    function(long StartDate, long EndDate, string SpanType),long
                        end


                    END


  CODE
    CalculatorUILSL()
