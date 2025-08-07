

  MEMBER('LSL_Calculator')

OMIT('***')
 * Created with Clarion 12.0
 * User: obrunker
 * Date: 5/08/2025
 * Time: 10:52 AM
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 ***



CalculatorUILSL     procedure()

EmploymentCommencement      long
CalculateTo                 long
WeeksOfEmployment           decimal(6,2)
WeeksEntitlement            decimal(6,2)

StartDate                       long
EndDate                         long
SpanDays                        long
SpanWeeks                       long
SpanMonths                      long
SpanYears                       long


Window                  WINDOW('LSL Calculator'),AT(,,281,151),CENTER,SYSTEM,FONT('Segoe UI',9),DOUBLE
                            SHEET,AT(2,2,277,129),USE(?SHEET1),COLOR(0E1E4FFH)
                                TAB('LSL Calculator'),USE(?TAB:LSL_Calc)
                                    PROMPT('Employment Commence Date:'),AT(10,22),USE(?EmploymentCommencement:Prompt) |
                                        ,TRN
                                    ENTRY(@D06),AT(213,20,58),USE(EmploymentCommencement),FLAT,LEFT
                                    PROMPT('Calculate to:'),AT(10,38),USE(?CalculateTo:Prompt),TRN
                                    ENTRY(@D06),AT(213,36,58),USE(CalculateTo),FLAT
                                    PROMPT('Weeks of Employment:'),AT(10,55),USE(?WeeksOfEmployment:Prompt), |
                                        TRN
                                    ENTRY(@N_6.1),AT(213,53,58),USE(WeeksOfEmployment),FLAT,DECIMAL(11), |
                                        READONLY
                                    PROMPT('Entitlement in Weeks:'),AT(10,71),USE(?Entitlement:Prompt),TRN
                                    ENTRY(@N_6.1),AT(213,69,58),USE(WeeksEntitlement),FLAT,DECIMAL(11), |
                                        READONLY
                                    BUTTON('Calculate'),AT(213,84,59),USE(?Calculate),FLAT
                                END
                                TAB('Timespan Calculator'),USE(?TAB:TimeSpanCalc)
                                    PROMPT('Start Date:'),AT(15,22),USE(?StartDate:Prompt),TRN
                                    ENTRY(@D06),AT(64,20),USE(StartDate)
                                    PROMPT('End Date:'),AT(160,22),USE(?EndDate:Prompt),TRN
                                    ENTRY(@D06),AT(209,20),USE(EndDate),FLAT
                                    GROUP('Time Span:'),AT(8,36,265,89),USE(?GROUP:TimeSpan),BOXED,TRN, |
                                        COLOR(0E6F0FAH)
                                        PROMPT('Days:'),AT(51,52),USE(?Days:Prompt),TRN
                                        ENTRY(@N_6),AT(225,50),USE(SpanDays),FLAT,RIGHT
                                        PROMPT('Weeks:'),AT(51,68),USE(?Weeks:Prompt),TRN
                                        ENTRY(@N_6),AT(225,66),USE(SpanWeeks),FLAT,RIGHT
                                        PROMPT('Months:'),AT(51,85),USE(?Months:Prompt),TRN
                                        ENTRY(@N_6),AT(225,83),USE(SpanMonths),FLAT,RIGHT
                                        PROMPT('Years:'),AT(51,101),USE(?Years:Prompt),TRN
                                        ENTRY(@N_6),AT(225,99),USE(SpanYears),FLAT,RIGHT
                                    END
                                END
                            END
                            BUTTON('Close'),AT(237,134,43),USE(?Close),FLAT
                        END

    code
        
        open(Window)
        ACCEPT
            
            case field()
            of ?EmploymentCommencement
                case event()
                of EVENT:Accepted
                    do CalculateLslEntitlement
                END

            of ?CalculateTo
                case event()
                of EVENT:Accepted
                    do CalculateLslEntitlement
                END

            of ?Calculate
                case event()
                of EVENT:Accepted
                    do CalculateLslEntitlement
                END
                
            of ?StartDate
                case event()
                of EVENT:Accepted
                    do CalculateSpans
                    DISPLAY
                end
                
            of ?EndDate
                case event()
                of EVENT:Accepted
                    do CalculateSpans
                    DISPLAY
                end
                
            of ?Close
                case event()
                of EVENT:Accepted
                    post(event:CloseWindow)
                END
                
            end
        END
        
        close(Window)

CalculateLslEntitlement           routine
    
    WeeksOfEmployment = TimeSpan(EmploymentCommencement, CalculateTo, SPANTYPE:Weeks)
    WeeksEntitlement  = WeeksOfEmployment * (1 / 60)
    display
        
CalculateSpans      routine
            SpanDays   = TimeSpan(StartDate, EndDate, SPANTYPE:Days)
            SpanWeeks  = TimeSpan(StartDate, EndDate, SPANTYPE:Weeks)
            SpanMonths = TimeSpan(StartDate, EndDate, SPANTYPE:Months)
            SpanYears  = TimeSpan(StartDate, EndDate, SPANTYPE:Years)
    

    
    