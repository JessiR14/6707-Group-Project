|    Column Name    |    Data Type    |    Description    |
| ------------------|-----------------|-------------------|
|    Location       |    Factor       |    Location of the field sampling. Options: Western (South Charleston, OH) or Wooster (Wooster, OH) |
|    Application    |    Factor       |    Whether the observation was completed before insecticide application or 24 hours after insecticide application. Insecticide applications timed with observations ONLY occurred in conventional fields. However, both treatments were sampled on same days. Options: Pre (prior to insecticide application) or Post (up to 24-hours post application) |
|    Date           |    Date         |    Date pollinator observations were completed. Format: YYYY-MM-DD |
|    Treatment      |    Factor       |    Pest management regime the field being sampled in is receiving. Options: Conventional (weekly, non-threshold based applications) or IPPM (Integrated Pest & Pollinator Management, threshold-based applications, pollinator-friendly products) |
|    Zone           |    Factor       |    Each field was divided into zones, in the style of a bullseye. Outer-most zone is 1, inner-most zone is 4. Based on distance from pollenizer plants & likelihood of pollen travel. Options: 1-4 |
|   Sample |  Factor  |  Per zone, four samples were taken (besides a few that had fewer samples or an extra sample). This variable identifies the individual  quadrat samples. |
|    Pollinator_category | Factor     |    Pollinator type observed in sampling quadrat. Simplified categories. Options: Bumble, Honey, Squash, Longhorn, Sweat, Striped Sweat, and Green Metallic Sweat |
|    Duration_of_visit |  Numeric     |    Time pollinator observed was inside quadrat in seconds. Timed up to 240 seconds. Options: 0-240 |
|    Flower_type    |    Factor       |    Whether the pollinator landed on a Male, Female, or Both watermelon flowers in the quadrat. Options: Male, Female, Both |
|    Pollination_event |  Factor      |    Whether the pollinator was observed moving from a Male to a Female flower (successful pollination event observed) in the quadrat at any point. Options: 1 (Yes) or 0 (No) |
|    Flower_ratio_m_to_f | Integer ?  |    The estimated flower ratio within the quadrat that pollinator observation took place (M:F). Options: Any Ratio |
|    Total_flowers | Integer | Total number of flowers within quadrat. Incomplete data due to deciding to start collecting after data collection began. To estimate bloom period. Options: Any whole number |


