import React from 'react'
import mapboxgl from 'mapbox-gl'

mapboxgl.accessToken = 'pk.eyJ1IjoicnBnYWdwYW5hbiIsImEiOiJjanRsMTU4N3AwM2xxM3lwM3EyYjlkNmVxIn0.hXeOR2w_OYb4jYaFjS9Cgg';

class Application extends React.Component {

  constructor(props: Props) {
    super(props);
    this.state = {
      lng: 121.243630,
      lat: 14.167754, 
      zoom: 17
    };
  }

  componentDidMount() {
    const { lng, lat, zoom } = this.state;

    const map = new mapboxgl.Map({
      container: this.mapContainer,
      style: 'mapbox://styles/mapbox/streets-v9',
      containerStyle: {height: "100vh", width: "100vw"},
      center: [lng, lat],
      zoom
    });

    map.on('move', () => {
      const { lng, lat } = map.getCenter();

      this.setState({
        lng: lng.toFixed(4),
        lat: lat.toFixed(4),
        zoom: map.getZoom().toFixed(2)
      });
    });
  }

  render() {
    const { lng, lat, zoom } = this.state;

    return (
      <div>
        <div >
          <div>{`Longitude: ${lng} Latitude: ${lat} Zoom: ${zoom}`}</div>
        </div>
        <div ref={el => this.mapContainer = el} />
      </div>
    );
  }
}

export default Application;