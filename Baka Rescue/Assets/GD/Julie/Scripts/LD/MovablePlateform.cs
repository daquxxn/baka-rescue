using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MovablePlateform : MonoBehaviour
{
    [SerializeField] private Vector3[] _points;
    [SerializeField] private int _pointNumber = 0;
    private Vector3 _currentTarget;

    [SerializeField] private float _tolerance = 0f;
    [SerializeField] private float _speed = 0f;
    [SerializeField] private float _delayTime = 0f;

    private float _delayStart = 0f;

    [SerializeField] private bool _automatic = true;

    

    // Start is called before the first frame update
    void Start()
    {
        if(_points.Length > 0)
        {
            _currentTarget = _points[0];
        }
        _tolerance = _speed * Time.deltaTime;
    }

    // Update is called once per frame
    void Update()
    {
        if(transform.position != _currentTarget)
        {
            MovePlateform();
        }
        else
        {
            UpdateTarget();
        }
    }

    void MovePlateform()
    {
        Vector3 heading = _currentTarget - transform.position;
        transform.position += (heading / heading.magnitude) * _speed * Time.deltaTime;
        if (heading.magnitude < _tolerance)
        {
            transform.position = _currentTarget;
            _delayStart = Time.time;
        }
    }

    void UpdateTarget()
    {
        if (_automatic)
            if(Time.time - _delayStart > _delayTime)
            {
                NextPlateform();
            }
    }

    public void NextPlateform()
    {
        _pointNumber++;
        if(_pointNumber >= _points.Length)
        {

            _pointNumber = 0;
        }
        _currentTarget = _points[_pointNumber];
    }


}
