# Salaries

Converts working time from Toggl csv file to decimal numbers.

## Usage

```
./salaries.rb csv_file people_file output_file
```
or
```
ruby salaries.rb csv_file people_file output_file
```

where:
- csv_file - file with data exported from Toggl service
- people_file - file with list of people for whom convertion should be done
- output_file - file with list of decimal numbers which represent working time

## Example

#### csv_file:
```
User,Registered time,,Amount (EUR)
Józef Zajączek,112:01:00,00:00:00,0.00
Jan Kowalski,110:55:00,00:00:00,0.00
```

#### people_file:
```
Kowalski Jan
Bond James
Zajączek Józef
```

#### output_file:
```
110.92
James Bond data not found.
112.02
```
