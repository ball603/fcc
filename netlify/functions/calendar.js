// Netlify serverless function to fetch Google Calendar iCal feed
// This avoids CORS issues by fetching server-side

exports.handler = async function(event, context) {
    const ICAL_URL = 'https://calendar.google.com/calendar/ical/davemoshermemorial%40gmail.com/public/basic.ics';
    
    try {
        const response = await fetch(ICAL_URL);
        
        if (!response.ok) {
            return {
                statusCode: response.status,
                body: JSON.stringify({ error: 'Failed to fetch calendar' })
            };
        }
        
        const icsText = await response.text();
        
        return {
            statusCode: 200,
            headers: {
                'Content-Type': 'text/calendar',
                'Access-Control-Allow-Origin': '*',
                'Cache-Control': 'public, max-age=300' // Cache for 5 minutes
            },
            body: icsText
        };
    } catch (error) {
        return {
            statusCode: 500,
            body: JSON.stringify({ error: error.message })
        };
    }
};
