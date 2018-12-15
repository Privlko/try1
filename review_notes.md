# Review notes

Two brief points: 

First, thank you for reading my paper and sending it out for review. Please also thank the reviewers for their comments which I think have strengthened the paper.  

Second, I am glad that the central argument has not been challenged. All three reviewers agree that the effects of job mobility have received little attention; all three agree that we should compare and contrast quits and promotions agains each other; all three agree that quits and promotions should have different effects. Although R3 takes issue with some hypotheses, the two aims of the paper seem accepted by all. I think this is really encouraging.

In the next section, I comment on the issues raised and outline how the original submission has changed.

## Reviewer 1:

R1 accepts the general argument of the article but is concerned with the methodology.  These are legitimate and warrant attention:

* *Page 15: discussion of the methodology is highly problematic. For example, the claim that “This is especially true for fixed-effects linear estimation which is susceptible to “omitted variable bias”” is not only for fixed-effects estimation but a general criticism of most regression models.*

** I review the methodology to reflect this comment. In my opinion, at least some limitations of FE estimation should be considered. I am happy to remove these at the request of the editor. The fact that ommitted variable bias is an issue for most forms of estimation seems to me unimportant, the methodology is focused on linear FE specifically. 

* *Besides, fixed-effects approach is robust to “omitted variable bias” as long as the excluded variables are observed and time-invariant and can be differenced out. This is also acknowledged later by the authors (see page 16, section 4.3, and again citing Wooldridge).*

**  Fixed-effects estimation is only robust to ommitted variable bias if the variable is time-constant, as both myself and reviewer 2 note. Time variant ommitted variables can lead to biased estimates, especially when these correlate with a theoretically important predictor (like job mobility); I have decided to emphasise the point in the updated version.

* *Page 17 discusses of the fixed-effects approach but no reference is made to alternative panel data modeling strategy (e.g. random effects and GMM) and why they’re not considered.*

** I accept this point. I update the paper to include a brief discussion over fixed and random effects regression. I also list the results of 2 hausmann tests; these show a correlation in between-within effects for several estimates. The results rule-out unbiased estimates using random-effects modelling, and confirm the need for a different approach. I think this justifies the use of fixed-effects estimation.

* *The main results reported are also hard to evaluate because the authors do not disclose the full set of results. Both Tables 2 and 3 include additional covariates which are not reported in the paper -- “control for general job satisfaction in each model (except for the model estimating satisfaction with work). Two macro variables; the unemployment rate and the rate of economic growth are also included”. This is particularly problematic because even Table 1 (descriptive stats) do not describe these variables and their exact measure/definition. *

** I ainclude another table listing the full output. It could be included as an appendix.

* *The model specification is also highly questionable – as described on pages 15-16, “Lastly, the survey year, the country’s unemployment rate, and the rate of economic growth are included in an effort to control for macro changes which may affect wages and subjective evaluations of work”. How can country level variables survive a within transformation in a fixed-effects model when they don’t vary across individuals in a given survey year? *

** I simplify the model and remove these controls.

* *The choice of outcome variables are not justified. What’s the full range of labor market and employment related outcomes in BHPS? Which were discarded and why? *

** This is a legitimate concern. The basic answer is that these outcomes often appear in articles exploring the effects of mobility. I have rewritten key sections of the paper to include a reference to earnings and conditions or job-fit.

* *The paper’s title is unclear: “Does mobility improve outcomes?” It should have been clarified what outcomes are being studied in the paper. The findings (abstract) also refer to “subjective outcomes” which is very vague. Most importantly the main results tables (2 and 3 – see page 29) also refer to objective and subjective outcomes. Only after careful inspection the dependent variables could be identified as (satisfaction with 3 dimensions of job and 3 observed characteristics of the job (pay, work hours etc)).*

** I update the paper and reference earnings growth and job fit throughout.

* *Table 2 involves dependent variables that are measured using likert scale. But no explanation is provided for using a linear specification – why not use regression models that allow for ordering in the values of the dependent variable? This issue should have been at least acknowledged by the authors*

* This is a legitimate concern. I briefly consider the importance of conditional logistic regression (stata command clogit). Since the output is similar, I committ to linear regression, which is used also for working time and gross pay.


## Reviewer 2: 

I am grateful to reviewer two for their positive comments. However, a concern about the practical implications of the study is raised. I expand this section of the paper; hopefully this fixes the issue. 


## Reviewer 3:

Reviewer 3 is mostly concerned with the paper's literature review. Here too, the general argument about mobility is accepted and encouraged. R3 also makes nine literature recommendations; I thoroughly read all of these and found them interesting and of a high quality. However, I think it's worth making three observations before turning to specific comments made by R3. 

First, all of the suggested articles are from the field of Personel Psychology. While this field is important, the framework used in Q&L sits in the field of economics and sociology, and cites work that sit in this approach. Both have justifications for why workers move, which are subtly different to those discussed in Personnel Psychology. Although some similarities exist between Psychology and Sociology regardin the topic, most of the articles considered in the literature review rely on either the job-match or job-search approach.

Second, all of the suggested papers consider the importance of push-factors on mobility. Hence, each paper explores and considers the impact of satisfaction on mobility, not the effects of mobility on satisfaction. I think this trend is a pitfall; I note this in the paper and specifically try to turn attention away from predicting mobility to the effects of mobility. R3 acknowledges that such articles are rare, even in their own field. 

Third, the suggested articles seem unconcerned with the relationship between mobility and satisfaction. In fact, several authors use satisfaction as a proxy for "desireability to move". In contrast, both job-match and job-search approaches specifically outline a link between earnigns and mobility, and job-fit and mobility. In these works, I think that satisfaction holds a more meaningful predictive power, where more specific relationships can be hypothesised. This is especially true with the reservation wage concept, found in the job-search approach. Nonetheless, some faults noted by R3 warrant attention. I now turn to these.

* *The article presents a novelty in the study of the impact of external and internal mobility on results. However, it is difficult to agree with the hypotheses put forward by the author. For example, the second hypothesis - there is a number of studies indicating that internal mobility is sometimes characterized by greater satisfaction than external mobility. And so already E. Jackofsky and L. Peters (1983) also considering the proposed variables in the study of labor mobility by J. Price and Mobley noticed that the employee's movements are important skills corresponding to the performance of specific tasks, his own influence on the direction displacements, a strong conviction of their own effectiveness and a desire for change, which is all the stronger the employee knows about real and alternative new jobs. This model is focused primarily on the individual predispositions of the individual determining its mobility and on processes related to the design of work, using the Hackman and Odhman models. 
There is little documented relationship between outcomes and mobility. For this, voluntary mobility appears here. The author does not respond to forced mobility. It seems to me that one would have to mention it. The author devotes a bit more attention to other variables than he assumes the title of work - outcomes and mobility.*

* *I consider that the relationship with literature is weak. There is a lot of evidence showing the consequences of mobility and not included in this article. It is pointed out, for example, that there is no difference between internal and external mobility (Carnicer, A. M. Sánchez, M. Pérez Pérez and M.J. V.Jiménez, 2004). In addition, there are a number of articles explaining the phenomenon of mobility and the factors that constitute them (Noe, Steffy, Barber 1988, Jackofsky, Griffeth, Hom Gaertner 2000 and many other items Ng, Feldman). In this article, the literature is included, but not representative for the discussed area. I recommend reaching out to those indicated - starting with March, Simon (1958) and Mobley (1977). There are few indications relating to the relationship between mobility and outcomes.*

* This point is noted. However, my literature review notes several studies where internal and external mobility yields significantly different results, including Gesthuizen 2009 with the International Journal of Manpower, and Tahlin. R3 cites Jackofsky and L. Peters (1983) when making the point. However, this article focused on the significance of satisfaction on models predicting internal and external mobility. It is true that dissatisfaction had a stronger effect on internal mobility; however my paper is more concerned with mobility's effects after the fact. Jackofsky amd Peters seem uninterested in the question and even make the following assumption *“It is reasonable to believe that intra- and interorganizational movement are similar with regard to their impact on individuals”*. This is the exact point my article tries to challenge. 

* Mobley makes an interesting set of observations regarding intention to quit and the cost of quitting. However the same pitfall emerges; the approach of the paper is satisfactions' effect on quitting, not the potential effects of quitting on satisfaction. R3 notes the importance of "desire for change" and "opportunity for change". These concepts are important in their own field, but may be less applicable to theoretical models which try to learn about the effects of quitting. 


* Ng's work features in the original submission.

* This point is noted, I emphasise the brief discussion of involuntary or forced mobility.

* R3 suggests there are several articles which consider the consequences of mobility, but does not include these. R3 also takes exception with hypothesis 2. Internal and external mobility will yield different effects on satsifaction and earnings. I cite the work of Tahlin, Gesthuizen, and Pavlopoulos when offering the hypothesis, all such works have found a similar result and have questioned why types of ombility bring about different effects. R3 cites Carnicer, Sanchez, Perez and Jimenez; a paper that argues that subjective feelings about work are strong predictors of internal mobility. Further, the study is cross-sectional which suggests the authors explore satsifaction as a predictor of movers and non-movers. This paper does not consider the consequences of mobility, and so I find R3's issues slightly confusing.

* *The methodology is correct. Well described, but there is no justification for this choice. I think that this part should also be extended. Why was this method chosen and not another one? *

* This point is noted and accepted, I take greater care in justifying the methodology.

* *This part of the work is at a good level. However, the statistics are at the basic level, there is no statistical justification for the results obtained. *

* This point is also accepted, a hausmann test is included which justifies the use of fixed-effects estimation.

* *In my opinion, there is a lack of strong practical implications. The ones that the author contains are basic, they do not bring anything new, they are obvious. Although there is a connection between the theory contained by the author (albeit poor) and own conclusions and implications. *

* I accept the point regarding practical implications, I expand this section. 

* *The language is correct and clear, made on the clarity of the article, I do not know the jargon, the author probably sure of himself right - sometimes all too confident*

* The point on language is noted; parts of the article have been toned down to accommodate R3.

