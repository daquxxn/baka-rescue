using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Lever : AElement
{
    [SerializeField] private GameObject _wallLever = null;
    [SerializeField] private Transform _lucioles = null;
    [SerializeField] private Transform _posLevier  = null;
    [SerializeField] private GameObject _fruitElec  = null;
    [SerializeField] private GameObject _fruitPasElec  = null;
    private bool _isElectrified = false;

    private AudioSource _leverDestroySD;

    private void Start()
    {
        _leverDestroySD = GetComponent<AudioSource>();
    }

    private void Update()
    {
        if (_isElectrified)
        {
            float step = 10 * Time.deltaTime;
            _lucioles.transform.position = Vector3.MoveTowards(_lucioles.position, _posLevier.position, step);
        }
    }
    public override void ElementalReaction(EElement element)
    {
        switch (element)
        {
            case EElement.THUNDER:
               if (_element == EElement.NONE)
                {
                    _leverDestroySD.Play();
                    _isElectrified = true;
                    Destroy(_wallLever);
                    _fruitPasElec.gameObject.SetActive(false);
                    _fruitElec.gameObject.SetActive(true);

                }
                break;
        }
    }

    private void OnTriggerEnter(Collider collider)
    {
        // Check if other is AElement
        AElement other = collider.GetComponent<AElement>();
        if (other != null)
        {
            // React with other's element
            ElementalReaction(other.Element);

            // Destroy other if it's a Projectile
            if (other is ElementalProjectile)
                Destroy(other.gameObject);
        }
    }
}
