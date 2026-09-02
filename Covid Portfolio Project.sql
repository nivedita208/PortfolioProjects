
SELECT * 
from PortfolioProject..CovidDeaths
Where continent is not null
order by 3,4

-- Looking at total cases  vs Total Deaths
-- Shows likelihood of dying if you contract  covid in your country
Select Location, date, total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
Where  location like '%states%'
and  continent is not null
order by 1, 2

--	Looking at Total Cases  vs Population
-- Shows what percentage of population got Covid 
SELECT Location, date , total_cases, Population, (total_cases/population)*100 as PercentPopulationInfected
From PortfolioProject.. CovidDeaths
-- Where location like '%states%'
Where continent is not null
order by 1, 2	

-- Looking at Countries with Highest Infection Rate compared to Population.
Select Location,Population , MAX(total_cases) as HighestInfectionCount, MAX(total_cases/Population) * 100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
Group by Location , Population
order by PercentPopulationInfected desc

-- Showing Countries with Highest Death count per Population
Select Location  , MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject.. CovidDeaths
Where continent is not null	
Group by Location
Order by TotalDeathCount desc

-- By Continent
Select continent , MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
Where continent is not null	
Group by continent
Order by TotalDeathCount desc

-- Showing cotinents with the highest death count  per population
Select continent , MAX(cast(Total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
Where continent is not null	
Group by continent
Order by TotalDeathCount desc

-- Global Numbers 
Select  SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int ))/SUM
(New_Cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
-- Where location like '%state%'
Where continent is not null
-- Group By date
order by 1,2

-- Looking at Total Population vs Vaccinations

select dea.continent,dea.location,dea.date,dea.population , vac.new_vaccinations
, SUM(Cast(vac.new_vaccinations as int )) OVER (Partition by dea.Location Order by dea.location, 
dea.Date) as  RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
from PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null
	order by 2,3

-- CTE
With PopvsVac (Continent,location,Date,Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
select dea.continent,dea.location,dea.date,dea.population , vac.new_vaccinations
, SUM(Cast(vac.new_vaccinations as int )) OVER (Partition by dea.Location Order by dea.location, 
dea.Date) as  RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
from PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null
	--order by 2,3
	)
	Select *, (RollingPeopleVaccinated/Population)*100
		From PopvsVac

-- TEMP TABLE
DROP TABLE if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into  #PercentPopulationVaccinated
select dea.continent,dea.location,dea.date,dea.population , vac.new_vaccinations
, SUM(Cast(vac.new_vaccinations as int )) OVER (Partition by dea.Location Order by dea.location, 
dea.Date) as  RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
from PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null

Select *, (RollingPeopleVaccinated/Population)*100
		From #PercentPopulationVaccinated

-- Creating	 View to store data for later visualizations
Create View PercentPopulationVaccinated as 
Select  dea.continent,dea.location,dea.date,dea.population , vac.new_vaccinations
, SUM(Cast(vac.new_vaccinations as int )) OVER (Partition by dea.Location Order by dea.location, 
dea.Date) as  RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
from PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3

Select * 
From  PercentPopulationVaccinated
